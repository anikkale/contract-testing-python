from pydantic import BaseModel, Field

class Cart(BaseModel):
    product_id: int
    quantity: int = Field(default = 1)