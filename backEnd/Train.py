from backEnd.ConvNet import ConvNetLayers
import torch
import torch.nn.functional as F
import torch.optim as optim
import torchvision.transforms as transforms
import torch.optim as optim
from CIFAR10DataLoader import CIFAR10DataLoader


cifar_data = CIFAR10DataLoader()

train_loader = cifar_data.get_trainloader()
test_loader = cifar_data.get_testloader()
classes = cifar_data.get_classes()

layer_specs = [
    {'in_channels': 1, 'out_channels': 32, 'kernel_size': 3, 'use_bn': True, 'dropout_rate': 0.2},
    {'in_channels': 32, 'out_channels': 64, 'kernel_size': 3, 'use_bn': True, 'dropout_rate': 0.3},
    {'in_channels': 64, 'out_channels': 128, 'kernel_size': 3, 'use_bn': True, 'dropout_rate': 0.4}
]
hyper_paramaters = {'learning_rate' : .001, 'num_epochs' : 10}
# Create an instance of ConvNetLayers
conv_net_layers = ConvNetLayers(layer_specs)

# Create a dummy input tensor
input_tensor = torch.randn(8, 1, 32, 32)  # Batch size of 8, 1 channel, 32x32 image

# Forward pass
output_tensor = conv_net_layers(input_tensor)
print(output_tensor.shape)  # Should print torch.Size([8, 128, 4, 4]), assuming input is 32x32 and it's downsampled to 4x4
model = ConvNetLayers()
optimizer = optim.SGD(model.parameters(), lr=hyper_paramaters.learning_rate)

# Training Loop
for epoch in range(hyper_paramaters.num_epochs):
    for batch_idx, (data, target) in enumerate(train_loader):
        
        # Zero the gradients
        optimizer.zero_grad()
        
        # Forward pass
        output = model(data)
        
        # Compute the loss
        loss = F.cross_entropy(output, target)
        
        # Backward pass
        loss.backward()
        
        # Update the parameters
        optimizer.step()
        
        if batch_idx % 5 == 0:
            print(f"Epoch [{epoch+1}/{hyper_paramaters.num_epochs}], Step [{batch_idx}/{len(train_loader)}], Loss: {loss.item():.4f}")
    for batch_idx, (data, target) in enumerate(test_loader):
        
        # Zero the gradients
        optimizer.zero_grad()
        
        # Forward pass
        output = model(data)
        
        # Compute the loss
        loss = F.cross_entropy(output, target)
        
        # Backward pass
        loss.backward()
        
        # Update the parameters
        optimizer.step()
        
        if batch_idx % 5 == 0:
            print(f"Epoch [{epoch+1}/{hyper_paramaters.num_epochs}], Step [{batch_idx}/{len(test_loader)}], Loss: {loss.item():.4f}")
# Create synthetic data
#X = np.random.rand(1000, 10)  # 1000 samples, 10 features
#y = 5 * X[:, 0] + 3 * X[:, 1] + np.random.randn(1000)  # Synthetic target

# Initialize and train the model
#catboost_regressor = CatBoostRegression()
#catboost_regressor.prepare_data(X, y, test_size=0.2)
#catboost_regressor.train(verbose=50)

# Make a prediction
#some_data = np.random.rand(5, 10)
#predictions = catboost_regressor.predict(some_data)
#print(f"Predictions: {predictions}")

# Evaluate the model
#metrics = catboost_regressor.evaluate()
#print(f"Evaluation metrics: {metrics}")
# Create synthetic data
#X = np.random.rand(1000, 10)  # 1000 samples, 10 features
#y = 5 * X[:, 0] + 3 * X[:, 1] + np.random.randn(1000)  # Synthetic target

# Initialize and train the model
#catboost_regressor = CatBoostRegression()
#catboost_regressor.prepare_data(X, y, test_size=0.2)
#catboost_regressor.train(verbose=50)

# Make a prediction
#some_data = np.random.rand(5, 10)
#predictions = catboost_regressor.predict(some_data)
#print(f"Predictions: {predictions}")

# Evaluate the model
#metrics = catboost_regressor.evaluate()
#print(f"Evaluation metrics: {metrics}")
