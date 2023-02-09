from pydantic import BaseModel, Field

class Product(BaseModel):
    name: str = Field(min_length=1, max_length=100)
    price: float = Field(default=0)
    description: str = Field(min_length=1, max_length=250)