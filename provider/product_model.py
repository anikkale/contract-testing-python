from sqlalchemy import Column, Integer, String
from provider.product_db import Base

class Products(Base):
    __tablename__ = "products"

    id = Column (Integer, primary_key=True, index= True)
    name = Column (String(100))
    price = Column (Integer)
    description = Column (String(250))