import socket
import json
from pydantic import ValidationError
from schema import MLModel, TrainingModelConfig, AIConfigurations, validJSON
import multiprocessing
import queue
import signal
import sys

# Define a request queue to hold incoming requests
request_queue = multiprocessing.Queue()

# Signal handler for graceful server termination
def handle_exit(signum, frame):
    global server_running
    server_running = False
    print("Server terminated by signal.")
    sys.exit(0)

# Register signal handlers
signal.signal(signal.SIGINT, handle_exit)
signal.signal(signal.SIGTERM, handle_exit)

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

def validate_and_process_data(data):
    try:
        valid_json = validJSON(**data)

        schema_type = valid_json.schemaType
        json_data = valid_json.JSON_data

        if schema_type == "MLModel":
            if isinstance(json_data, MLModel):
                print("Received and validated MLModel:")
                print(json_data.dict())
            else:
                print("Invalid MLModel data")
        elif schema_type == "TrainingModelConfig":
            if isinstance(json_data, TrainingModelConfig):
                print("Received and validated TrainingModelConfig:")
                print(json_data.dict())
            else:
                print("Invalid TrainingModelConfig data")
        elif schema_type == "AIConfigurations":
            if isinstance(json_data, AIConfigurations):
                print("Received and validated AIConfigurations:")
                print(json_data.dict())
            else:
                print("Invalid AIConfigurations data")
        else:
            print(f"Received unrecognized schemaType: {schema_type}")
            return b"Unrecognized schemaType\n"

        response = f"Received and validated {schema_type} data\n"
        return response.encode()
    except ValidationError as e:
        pass

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
            
            # Put the client socket into the request queue for processing
            request_queue.put(client_socket)
    except KeyboardInterrupt:
        print("Server terminated by user.")
    finally:
        server_socket.close()
        print("Server socket closed.")

def handle_client(client_socket):
    try:
        json_data = receive_variable_length_json(client_socket)
        if json_data is not None:
            response = validate_and_process_data(json_data)
            client_socket.send(response)
    except KeyboardInterrupt:
        pass
    finally:
        client_socket.close()
        print("Client socket closed.")

def process_requests():
    while server_running:
        try:
            client_socket = request_queue.get()
            if client_socket is not None:
                handle_client(client_socket)
        except KeyboardInterrupt:
            print("Server terminated by user.")
            break

if __name__ == "__main__":
    start_server()
    process_requests()
