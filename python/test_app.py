"""
Unit tests for the demo application.
"""

from app import greet, add, multiply

def test_greet():
    result = greet("Jenkins")
    assert "Hello, Jenkins!" in result
    print("✓ test_greet passed")

def test_add():
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
    assert add(0, 0) == 0
    print("✓ test_add passed")

def test_multiply():
    assert multiply(4, 5) == 20
    assert multiply(0, 100) == 0
    assert multiply(-2, 3) == -6
    print("✓ test_multiply passed")

if __name__ == "__main__":
    test_greet()
    test_add()
    test_multiply()
    print("\n🎉 All tests passed!")

