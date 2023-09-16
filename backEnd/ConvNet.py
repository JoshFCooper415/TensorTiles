import torch
import torch.nn as nn
import torch.nn.functional as F

class ConvNetBlock(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size=3, stride=1, padding=1, use_bn=True, dropout_rate=0.0, activation_fn=nn.ReLU):
        super(ConvNetBlock, self).__init__()
        
        # Define the convolutional layer
        self.conv = nn.Conv2d(in_channels, out_channels, kernel_size, stride, padding)
        # Optionally add batch normalization
        self.use_bn = use_bn
        if use_bn:
            self.bn = nn.BatchNorm2d(out_channels)
        
        # Optionally add dropout
        self.use_dropout = dropout_rate > 0
        if self.use_dropout:
            self.dropout = nn.Dropout2d(dropout_rate)
        
        # Define the activation function
        self.activation_fn = activation_fn()
        
    def forward(self, x):
        # Forward pass through convolutional layer
        x = self.conv(x)
        
        # Forward pass through batch normalization
        if self.use_bn:
            x = self.bn(x)
        
        # Forward pass through activation function
        x = self.activation_fn(x)
        
        # Forward pass through dropout layer
        if self.use_dropout:
            x = self.dropout(x)
        
        return x

class ConvNetLayers(nn.Module):
    def __init__(self, layer_specs):  # layer_specs is a list of dictionaries
        super(ConvNetLayers, self).__init__()
        self.fc = None
        self.layers = nn.ModuleList()
        self.layer_specs = layer_specs
        
        for spec in layer_specs:
            layer = ConvNetBlock(
                in_channels=spec['in_channels'],
                out_channels=spec['out_channels'],
                kernel_size=spec.get('kernel_size', 3),
                use_bn=spec.get('use_bn', True),
                dropout_rate=spec.get('dropout_rate', 0.0)
            )
            self.layers.append(layer)
    def initialize_fc(self, dataset):
        if dataset == "CIFAR10":
            self.fc = nn.Linear(640,10)
        elif dataset == "MNIST":
            self.fc = nn.Linear(196,10)
    def forward(self, x):
        if self.fc is None:
            raise RuntimeError("Fully connected layer (self.fc) has not been initialized.")

        for layer in self.layers:
            x = layer(x)
            x = F.max_pool2d(x, 2)

        # Flattening the tensor and passing through the fully connected layer
        x = x.view(x.size(0), -1)
        x = self.fc(x)
    
        return x