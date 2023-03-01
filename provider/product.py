from http.client import HTTPException
from fastapi import FastAPI, Depends, Response, status
import provider.product_schema as product_schema
import provider.product_model as product_model
from provider.product_db import engine, SessionLocal
from sqlalchemy.orm import Session

app = FastAPI()
product_model.Base.metadata.create_all(bind=engine)

def read_db():
    try:
        db= SessionLocal()
        yield db
    finally:
        db.close()

@app.get("/products")
def get_products(db: Session = Depends(read_db)):
    return db.query(product_model.Products).all()

@app.get("/product/{item_id}")
def get_product(response: Response, item_id: int, db: Session = Depends(read_db)):
    item_model = db.query(product_model.Products).filter(product_model.Products.id == item_id).first()
    if item_model is None:
        response.status_code = status.HTTP_404_NOT_FOUND
    else:
        return {
                "product_id": item_model.id,
                "name": item_model.name, 
                "price": item_model.price,
                "description": item_model.description
            }

@app.post("/product")
def add_product(response: Response, item: product_schema.Product, db: Session = Depends(read_db)):
    item_model = product_model.Products()
    item_model.name = item.name
    item_model.price = item.price
    item_model.description = item.description

    db.add(item_model)
    db.commit()
    response.status_code = status.HTTP_201_CREATED
    return item