import torch
import torch.nn as nn
import torch.nn.functional as F

class FeedForwardBlock(nn.Module):
    def __init__(self, in_features, out_features, use_bn=True, dropout_rate=0.0, activation_fn=nn.ReLU):
        super(FeedForwardBlock, self).__init__()
        
        # Define the fully connected (linear) layer
        self.fc = nn.Linear(in_features, out_features)
        
        # Optionally add batch normalization
        self.use_bn = use_bn
        if use_bn:
            self.bn = nn.BatchNorm1d(out_features)
        
        # Optionally add dropout
        self.use_dropout = dropout_rate > 0
        if self.use_dropout:
            self.dropout = nn.Dropout(dropout_rate)
        
        # Define the activation function
        self.activation_fn = activation_fn()
        
    def forward(self, x):
        # Forward pass through fully connected layer
        x = self.fc(x)
        
        # Forward pass through batch normalization
        if self.use_bn:
            x = self.bn(x)
        
        # Forward pass through activation function
        x = self.activation_fn(x)
        
        # Forward pass through dropout layer
        if self.use_dropout:
            x = self.dropout(x)
        
        return x

class FeedForwardLayers(nn.Module):
    def __init__(self, layer_specs):  # layer_specs is a list of dictionaries
        super(FeedForwardLayers, self).__init__()
        
        self.layers = nn.ModuleList()
        
        for spec in layer_specs:
            layer = FeedForwardBlock(
                in_features=spec['in_features'],
                out_features=spec['out_features'],
                use_bn=spec.get('use_bn', True),
                dropout_rate=spec.get('dropout_rate', 0.0),
                activation_fn=spec.get('activation_fn', nn.ReLU)
            )
            self.layers.append(layer)
            
    def forward(self, x):
        for layer in self.layers:
            x = layer(x)
        return x
'''
# Example usage
layer_specs = [
    {'in_features': 784, 'out_features': 512},
    {'in_features': 512, 'out_features': 256, 'dropout_rate': 0.5},
    {'in_features': 256, 'out_features': 10, 'use_bn': False, 'activation_fn': nn.Softmax}
]

model = FeedForwardLayers(layer_specs)

# Dummy input of shape [batch_size, num_features]
x = torch.randn(32, 784)

# Forward pass
out = model(x)
print(out.shape)  # Output shape should be [32, 10]
'''