from http.client import HTTPException
from fastapi import FastAPI, Depends, Response, status
import consumer.cart_schema as cart_schema
import consumer.cart_model as cart_model
from consumer.cart_db import engine, SessionLocal
from sqlalchemy.orm import Session
import requests
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse
from pydantic import BaseModel, Field


app = FastAPI()
cart_model.Base.metadata.create_all(bind=engine)

def read_db():
    try:
        db= SessionLocal()
        yield db
    finally:
        db.close()

# Call Provider service
def get_product_info(base_url,product_id):
    res = requests.get(f'{base_url}/product/{product_id}')
    return res.json()

@app.get("/")
def get_items(db: Session = Depends(read_db)):
    return db.query(cart_model.Carts).all()

@app.post("/add-to-cart")
def add_to_cart(response: Response,cart: cart_schema.Cart, db: Session = Depends(read_db)):
    cart_columns = cart_model.Carts()
    product_info = get_product_info('http://localhost:8000',cart.product_id)
    cart_columns.product_id = cart.product_id
    cart_columns.name = product_info['name']
    cart_columns.description = product_info['description']
    cart_columns.final_price = product_info['price'] * cart.quantity
    cart_columns.stock_status = "ADDED_TO_BASKET"

    db.add(cart_columns)
    db.commit()
    response.status_code = status.HTTP_201_CREATED

    return {
        **cart.dict(), 
        "name": cart_columns.name,
        "description": cart_columns.description,
        "final_price": cart_columns.final_price,
        "stock_status": "ADDED_TO_BASKET"
    }
     