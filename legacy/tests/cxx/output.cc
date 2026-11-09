// What the C++ compiler generates, compared with tests/cxx/output.*.s.
// It covers what a program without libstdc++ can use: classes and their
// layout, virtual functions and destructors, multiple inheritance, global
// constructors and destructors, new and delete, templates, overloading,
// references, namespaces and type identification.

extern "C" int printf(const char *, ...);

namespace geometry {

struct Shape {
	virtual ~Shape() {}
	virtual int area() const = 0;
	virtual const char *name() const { return "shape"; }
};

struct Rect : Shape {
	int w, h;
	Rect(int w, int h) : w(w), h(h) {}
	int area() const { return w * h; }
	const char *name() const { return "rect"; }
};

struct Square : Rect {
	Square(int side) : Rect(side, side) {}
	const char *name() const { return "square"; }
};

}

struct Named {
	virtual ~Named() {}
	virtual const char *label() const = 0;
};

struct Labeled : geometry::Rect, Named {
	Labeled(int w, int h) : Rect(w, h) {}
	const char *label() const { return "labeled"; }
};

template <class T, int N>
struct Stack {
	T items[N];
	int top;
	Stack() : top(0) {}
	void push(const T &v) { if (top < N) items[top++] = v; }
	T pop() { return top > 0 ? items[--top] : T(); }
	int size() const { return top; }
};

template <class T>
T largest(T a, T b) { return a < b ? b : a; }

struct Fixed {
	int raw;
	Fixed() : raw(0) {}
	explicit Fixed(int v) : raw(v << 8) {}
	Fixed operator+(const Fixed &o) const { Fixed r(0); r.raw = raw + o.raw; return r; }
	Fixed operator*(const Fixed &o) const { Fixed r(0); r.raw = (raw * o.raw) >> 8; return r; }
	bool operator<(const Fixed &o) const { return raw < o.raw; }
};

int counter;

struct Counted {
	int id;
	Counted() : id(++counter) {}
	~Counted() { --counter; }
};

Counted first, second;

static int swap_sum(int &a, int &b)
{
	int t = a;
	a = b;
	b = t;
	return a + b;
}

int total(const geometry::Shape &s) { return s.area(); }

int main()
{
	geometry::Shape *shapes[3];
	shapes[0] = new geometry::Rect(2, 3);
	shapes[1] = new geometry::Square(4);
	shapes[2] = new Labeled(5, 6);

	int sum = 0;
	for (int i = 0; i < 3; i++) {
		sum += total(*shapes[i]);
		printf("%s %d\n", shapes[i]->name(), shapes[i]->area());
	}
	Named *n = dynamic_cast<Named *>(shapes[2]);
	if (n)
		printf("%s\n", n->label());
	for (int i = 0; i < 3; i++)
		delete shapes[i];

	Stack<int, 8> ints;
	for (int i = 0; i < 10; i++)
		ints.push(i * i);
	Stack<Fixed, 2> fixed;
	fixed.push(Fixed(3));
	fixed.push(Fixed(2) * Fixed(5));

	int a = 1, b = 2;
	sum += swap_sum(a, b) + ints.pop() + ints.size();
	sum += largest(a, b) + largest(Fixed(1), Fixed(2) + Fixed(1)).raw;
	sum += fixed.pop().raw + first.id + second.id + counter;

	int *block = new int[16];
	for (int i = 0; i < 16; i++)
		block[i] = i;
	sum += block[15];
	delete[] block;

	printf("%d\n", sum);
	return sum;
}
