from sqlalchemy import Column, Integer, String, Float,ForeignKey
from consumer.cart_db import Base

class Carts(Base):
    __tablename__ = "carts"

    id = Column(Integer, primary_key=True, index= True)
    product_id = Column(Integer)
    name = Column(String(100))
    description = Column(String(250))
    final_price = Column(Float)
    stock_status = Column(String)