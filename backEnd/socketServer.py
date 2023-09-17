import socket
import json
from pydantic import ValidationError
from PIL import Image
from io import BytesIO
import schema
import ModelRunner
import torch
import base64
import os

# Variable to track the server's running state
server_running = True
runner = ModelRunner


def receive_variable_length_json(client_socket):
    try:
        # Set the socket to non-blocking mode
        client_socket.setblocking(False)

        buffer = b""
        while True:
            try:
                data = client_socket.recv(4096)
                print(data)
                if not data:
                    break

                buffer += data

                # Check if we have received a complete JSON object
                try:
                    json_data = json.loads(buffer.decode())
                    return json_data
                except ValueError as e:
                    print("ValueError: ", e)
            except BlockingIOError:
                pass

    except Exception as e:
        print(f"Error in receive_variable_length_json: {str(e)}")
        # Handle the error appropriately, e.g., close the socket gracefully


def get_expected_schema(data) -> type:
    schema_type = data.get("schemaType")
    if schema_type == "MLModel":
        return schema.MLModel
    elif schema_type == "TrainingModelConfig":
        return schema.TrainingModelConfig
    elif schema_type == "AIConfigurations":
        return schema.AIConfigurations
    elif schema_type == "ServerCommand":
        return schema.ServerCommand
    elif schema_type == "Image":
        return schema.Image
    elif schema_type == "Text":
        return schema.Text
    elif schema_type == "LoseData":
        return schema.LossData
    elif schema_type == schema_type.TrainingData:
        return schema.TrainingData
    else:
        raise ValueError(f"Received unrecognized schemaType: {schema_type}")


def validate_and_process_data(data):
    global runner
    response = "This is an empty string"
    try:

        expected_schema = get_expected_schema(data)
        json_data = data.get("JSON_data")

        try:
            print("expected Schema: ", expected_schema)
            parsed_data = expected_schema.parse_obj(json_data)
            print(f"Received and trusted {expected_schema.__name__} data:")
            print(parsed_data.dict())
            if isinstance(parsed_data, schema.MLModel):
                runner = ModelRunner.ModelRunner(
                    ["CNN", parsed_data.layer_specs, parsed_data.hyper_parameters, parsed_data.data_set])
                response = f"Received and trusted {expected_schema.__name__} data\n"
            elif isinstance(parsed_data, schema.Image):
                # Decode the base64-encoded image data
                image_data = base64.b64decode(parsed_data.image.data)
                img_format = parsed_data.format

                # Determine the directory where the server script is located
                script_directory = os.path.dirname(os.path.abspath(__file__))
                local_image_path = os.path.join(script_directory, "image.png")
                with open(local_image_path, "wb") as image_file:
                    image_file.write(image_data)

                response = runner.inference(local_image_path)
            elif isinstance(parsed_data, schema.ServerCommand):
                if parsed_data.command == "stopserver":
                    server_running = False
                    response = "Server stopping..."
                elif parsed_data.command == "start-training":
                    response = "[" + ','.join(runner.run()) + "]"
                else:
                    response = "Not a Valid ServerCommand"

            elif isinstance(parsed_data, schema.TrainingData):
                response = runner.args['num_epochs']
            elif isinstance(parsed_data, schema.LossData):
                runner.model.evaluate_model()
                response = runner.model.acc_arr

        except ValidationError as e:
            print(f"Validation error: {e}")
            response = f"Invalid {expected_schema.__name__} data\n"

        return response.encode()
    except Exception as e:
        print(f"Error: {str(e)}")
        return None, b"Error\n"


def start_server():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_host = 'localhost'
    server_port = 8080

    server_socket.bind((server_host, server_port))
    server_socket.listen(1)
    print(f"Server listening on {server_host}:{server_port}")

    try:
        while server_running:
            client_socket, client_address = server_socket.accept()
            print(f"Connection established with {client_address}")

            json_data = receive_variable_length_json(client_socket)
            if json_data is not None:
                response = validate_and_process_data(json_data)
                if isinstance(response, tuple):
                    client_socket.send(b"IT DIDNT WORK")

            client_socket.close()
            print("Client socket closed.")

    except KeyboardInterrupt:
        print("Server terminated by user.")
    finally:
        server_socket.close()
        print("Server socket closed.")


if __name__ == "__main__":
    start_server()
