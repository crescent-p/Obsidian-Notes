Composite key. Just set more than one column to be primary key to say they are composite keys.

```python
class Votes(Base):
    __tablename__ = "votes"

    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False, primary_key=True)
    posts_id = Column(Integer, ForeignKey("posts.id", ondelete="CASCADE"), nullable=False, primary_key=True)
```

