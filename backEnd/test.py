import torch
from ConvNet import ConvNetLayers
from MNISTDataLoader import MNISTDataLoader
import torch.nn as nn

device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
layer_specs = [
            {'in_channels': 3, 'out_channels': 64, 'kernel_size': 5, 'use_bn': True, 'dropout_rate': 0.0}
            ]
# Initialize your model and move to GPU if available
model = ConvNetLayers(layer_specs)
model.initialize_fc("MNIST")  # or "CIFAR10"
model = model.to(device)

# Define loss function and optimizer
criterion = nn.CrossEntropyLoss()
optimizer = torch.optim.Adam(model.parameters(), lr=1e-3)

# MNIST example
data_loader = MNISTDataLoader()

# Training loop
num_epochs = 10
for epoch in range(num_epochs):
    running_loss = 0.0
    for i, data in enumerate(data_loader.get_trainloader(), 0):
        inputs, labels = data
        inputs, labels = inputs.to(device), labels.to(device)
        
        # Zero the parameter gradients
        optimizer.zero_grad()
        
        # Forward pass, backward pass, optimize
        outputs = model(inputs)
        loss = criterion(outputs, labels)
        loss.backward()
        optimizer.step()
        
        # Print statistics
        running_loss += loss.item()
        if i % 100 == 99:  # Print every 100 mini-batches
            print(f"[{epoch + 1}, {i + 1}] loss: {running_loss / 100:.3f}")
            running_loss = 0.0

print("Finished Training")
