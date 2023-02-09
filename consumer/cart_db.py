import os
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

db_dir = "./consumer/cart.db"
DB_URL = "sqlite:///" + os.path.abspath(db_dir)

engine = create_engine(DB_URL, connect_args={"check_same_thread": False})

Base = declarative_base()

SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False)


