from pydantic import BaseModel, validator


class MLSchema(BaseModel):
    layer_spec: dict
    hyper_parameters: dict

    @validator("layer_spec")
    def validate_layer_spec(cls, v):
        for key, value in v.items():
            # Add validation logic for specific key-value pairs
            if key == "in_channels" and not isinstance(value, int):
                raise ValueError("in_channel must be an integer.")
            if key == "out_channels" and not isinstance(value, int):
                raise ValueError("out_channel must be a integer.")
            if key == "kernal_size" and not isinstance(value, int):
                raise ValueError("kernal_size must be an integer.")
            if key == "use_bn" and not isinstance(value, bool):
                raise ValueError("use_bn must be a boolean value.")
            if key == "dropout_rate" and not isinstance(value, float):
                raise ValueError("dropout_rate must be a float")
            else:
                raise ValueError("Unrecognized Garbage Sent to Server.")
        return v
    
    @validator("hyper_parameters")
    def validate_hyper_parameters(cls, v):
        for key, value in v.items():
            if key == "learning_rate" and not isinstance(value, float):
                raise ValueError("learning_rate must be a float.")
            if key == "num_epochs" and not isinstance(value, int):
                raise ValueError("num_epochs must be an integer.")
            else:
                raise ValueError("Unrecognized Garbage Sent to Server.")

    
