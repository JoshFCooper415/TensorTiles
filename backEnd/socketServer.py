import socket
import signal
import sys

def main():
    # Create a server socket
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_host = 'localhost'  # Replace with your desired host
    server_port = 8080  # Replace with your desired port

    # Bind the server socket to the host and port
    server_socket.bind((server_host, server_port))

    # Listen for incoming connections (maximum 1 queued connection)
    server_socket.listen(1)
    print(f"Server listening on {server_host}:{server_port}")

    def handle_signal(sig, frame):
        print(f"Received signal {sig}, closing server...")
        server_socket.close()
        sys.exit(0)

    # Register a signal handler for Ctrl+C (SIGINT)
    signal.signal(signal.SIGINT, handle_signal)  # Ctrl+C

    try:
        # Accept client connections
        client_socket, client_address = server_socket.accept()
        print(f"Connection established with {client_address}")

        while True:
            # Receive data from the client
            data = client_socket.recv(1024)

            if not data:
                break  # Connection closed

            # Handle the received data here
            response = b"Received: " + data

            # Send a response back to the client
            client_socket.send(response)

    except KeyboardInterrupt:
        print("Server terminated by user.")
    finally:
        # Clean up
        client_socket.close()
        server_socket.close()
        print("Server and client sockets closed.")

if __name__ == "__main__":
    main()