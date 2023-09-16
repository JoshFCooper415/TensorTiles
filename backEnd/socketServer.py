import socket
import json
from pydantic import ValidationError
from schema import MLModel, TrainingModelConfig, AIConfigurations, ServerCommand

# Variable to track the server's running state
server_running = True

    
def receive_variable_length_json(client_socket):
    try:
        # Set the socket to non-blocking mode
        client_socket.setblocking(False)

        buffer = b""
        while True:
            try:
                data = client_socket.recv(1024)
                if not data:
                    break

                buffer += data

                # Check if we have received a complete JSON object
                try:
                    json_data = json.loads(buffer.decode())
                    return json_data
                except ValueError:
                    continue
            except BlockingIOError:
                pass

    except Exception as e:
        print(f"Error in receive_variable_length_json: {str(e)}")
        # Handle the error appropriately, e.g., close the socket gracefully

def get_expected_schema(data) -> type:
    schema_type = data.get("schemaType")
    if schema_type == "MLModel":
        return MLModel
    elif schema_type == "TrainingModelConfig":
        return TrainingModelConfig
    elif schema_type == "AIConfigurations":
        return AIConfigurations
    elif schema_type == "ServerCommand":
        return ServerCommand
    else:
        raise ValueError(f"Received unrecognized schemaType: {schema_type}")


def validate_and_process_data(data):
    try:

        expected_schema = get_expected_schema(data)
        json_data = data.get("JSON_data")

        try:
            print("expected Schema: ", expected_schema)
            parsed_data = expected_schema.parse_obj(json_data)
            print(f"Received and trusted {expected_schema.__name__} data:")
            print(parsed_data.dict())
            response = f"Received and trusted {expected_schema.__name__} data\n"
        except ValidationError as e:
            print(f"Validation error: {e}")
            response = f"Invalid {expected_schema.__name__} data\n"

        return parsed_data, response.encode()
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
                if not isinstance(response, tuple):
                    client_socket.send("IT DIDNT WORK")

            client_socket.close()
            print("Client socket closed.")

    except KeyboardInterrupt:
        print("Server terminated by user.")
    finally:
        server_socket.close()
        print("Server socket closed.")

if __name__ == "__main__":
    start_server()
