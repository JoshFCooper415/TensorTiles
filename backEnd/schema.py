from pydantic import BaseModel, validator
from typing import List, Dict, Union


class MLModel(BaseModel):
    # List of dictionaries with flexible value types
    layer_specs: List[Dict[str, Union[int, bool, float]]]
    hyper_parameters: dict  # Dictionary with specific keys
    data_set: str

    @validator("layer_specs")
    def validate_layer_spec(cls, value):
        for spec in value:
            for key, val in spec.items():
                if key == "in_channels" and not isinstance(val, int):
                    raise ValueError("in_channels must be int")
                elif key == "out_channels" and not isinstance(val, int):
                    raise ValueError("out_channels must be int")
                elif key == "kernel_size" and not isinstance(val, int):
                    raise ValueError("kernel_size must be int")
                elif key == "use_bn" and not isinstance(val, bool):
                    raise ValueError("use_bn must be bool")
                elif key == "dropout_rate" and not isinstance(val, float):
                    raise ValueError("dropout_rate must be float")
        return value

    @validator("hyper_parameters")
    def validate__hyper_parameters(cls, value):
        for key, val in value.items():
            if key == "learning_rate" and not isinstance(val, float):
                raise ValueError("learning_rate must be float")
            elif key == "num_epochs" and not isinstance(val, int):
                raise ValueError("num_epochs must be int")
        return value


class TrainingModelConfig(BaseModel):
    learning_rate: float
    depth: int
    n_estimators: int
    target: str
    dropedFeatures: List[str]


class AIConfigurations(BaseModel):
    args: List[Union[str, TrainingModelConfig]]


class LossData(BaseModel):
    data: list


class TrainingData(BaseModel):
    numberOfEpochs: int


class ServerCommand(BaseModel):
    command: str
    parameters: dict


class Image(BaseModel):
    format: str
    data: str


class Text(BaseModel):
    text: str
