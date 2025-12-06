"""
Demo Application for Jenkins CI/CD Pipeline
This is a simple Python app to demonstrate the CI/CD process.
"""

def greet(name: str) -> str:
    """Return a greeting message."""
    return f"Hello, {name}! Welcome to CI/CD with Jenkins!"

def add(a: int, b: int) -> int:
    """Add two numbers."""
    return a + b

def multiply(a: int, b: int) -> int:
    """Multiply two numbers."""
    return a * b

if __name__ == "__main__":
    print(greet("Developer"))
    print(f"2 + 3 = {add(2, 3)}")
    print(f"4 * 5 = {multiply(4, 5)}")

