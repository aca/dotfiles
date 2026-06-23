class MyClass:
    def method(self):
        x = 1
        return x

    @staticmethod
    def static_method():
        pass

    @classmethod
    def class_method(cls):
        pass

    @property
    def my_property(self):
        return self._value

    class NestedClass:
        def nested_method(self):
            pass


def standalone():
    pass


@decorator
def decorated():
    pass


async def async_func():
    await something()


def outer():
    def inner():
        x = 1
        return x
    return inner


class OuterClass:
    class InnerClass:
        class DeepClass:
            def deep_method(self):
                pass


config = {
    "database": {
        "host": "localhost",
        "port": 5432,
    },
    "settings": {
        "debug": True,
    },
}
