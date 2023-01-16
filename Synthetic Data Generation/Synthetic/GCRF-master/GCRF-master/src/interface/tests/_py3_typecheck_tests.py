from ..typecheck import compatible
from ..typed_signature import TypedSignature


def test_allow_new_params_with_defaults_with_kwonly():
    @TypedSignature
    def iface(a, b, c):  # pragma: nocover
        pass

    @TypedSignature
    def impl(a, b, c, d=3, e=5, *, f=5):  # pragma: nocover
        pass

    assert compatible(impl, iface)
    assert not compatible(iface, impl)


def test_allow_reorder_kwonlys():
    @TypedSignature
    def foo(a, b, c, *, d, e, f):  # pragma: nocover
        pass

    @TypedSignature
    def bar(a, b, c, *, f, d, e):  # pragma: nocover
        pass

    assert compatible(foo, bar)
    assert compatible(bar, foo)


def test_allow_default_changes():
    @TypedSignature
    def foo(a, b, c=3, *, d=1, e, f):  # pragma: nocover
        pass

    @TypedSignature
    def bar(a, b, c=5, *, f, e, d=12):  # pragma: nocover
        pass

    assert compatible(foo, bar)
    assert compatible(bar, foo)


def test_disallow_kwonly_to_positional():
    @TypedSignature
    def foo(a, *, b):  # pragma: nocover
        pass

    @TypedSignature
    def bar(a, b):  # pragma: nocover
        pass

    assert not compatible(foo, bar)
    assert not compatible(bar, foo)
