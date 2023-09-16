from catboost import CatBoostRegressor, Pool
from sklearn.model_selection import train_test_split
import numpy as np

class CatBoostRegression:
    def __init__(self, params=None):
        # Initialize CatBoost parameters
        self.params = params if params else {
            'iterations': 500,
            'learning_rate': 0.1,
            'depth': 6
        }
        # Initialize the model
        self.model = CatBoostRegressor(**self.params)
        
    def prepare_data(self, X, y, test_size=0.2, random_state=None):
        """
        Split the data into training and testing datasets.
        """
        self.X_train, self.X_test, self.y_train, self.y_test = train_test_split(
            X, y, test_size=test_size, random_state=random_state
        )
        self.train_pool = Pool(self.X_train, self.y_train)
        self.test_pool = Pool(self.X_test, self.y_test)
        
    def train(self, verbose=True):
        """
        Train the CatBoost model.
        """
        self.model.fit(self.train_pool, eval_set=self.test_pool, verbose=verbose)
        
    def predict(self, X):
        """
        Make predictions using the trained model.
        """
        return self.model.predict(X)

    def evaluate(self):
        """
        Evaluate the trained model on the test dataset.
        """
        return self.model.eval_metrics(self.test_pool, ['RMSE', 'MAE'])