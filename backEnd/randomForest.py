from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, mean_absolute_error
import numpy as np

class RandomForestRegression:
    def __init__(self, params=None):
        # Initialize Random Forest parameters
        self.params = params if params else {
            'n_estimators': 100,
            'max_depth': None,
            'random_state': 42
        }
        # Initialize the model
        self.model = RandomForestRegressor(**self.params)
        
    def prepare_data(self, X, y, test_size=0.2, random_state=None):
        """
        Split the data into training and testing datasets.
        """
        self.X_train, self.X_test, self.y_train, self.y_test = train_test_split(
            X, y, test_size=test_size, random_state=random_state
        )
        
    def train(self):
        """
        Train the Random Forest model.
        """
        self.model.fit(self.X_train, self.y_train)
        
    def predict(self, X):
        """
        Make predictions using the trained model.
        """
        return self.model.predict(X)

    def evaluate(self):
        """
        Evaluate the trained model on the test dataset.
        """
        y_pred = self.predict(self.X_test)
        rmse = np.sqrt(mean_squared_error(self.y_test, y_pred))
        mae = mean_absolute_error(self.y_test, y_pred)
        return {'RMSE': rmse, 'MAE': mae}

