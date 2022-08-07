defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {float, float}

  import :math, only: [sqrt: 1, pow: 2, cos: 1, sin: 1]
  import Kernel, except: [div: 2]

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: float
  def real({real_part, _}) do
    real_part
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: float
  def imaginary({_, imaginary_part}) do
    imaginary_part
  end

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | float, b :: complex | float) :: complex
  def mul({a_real, a_imaginary}, {b_real, b_imaginary}) do
    real = a_real * b_real - a_imaginary * b_imaginary
    imaginary = a_real * b_imaginary + a_imaginary * b_real
    {real, imaginary}
  end

  def mul(real, {_, _} = complex), do: mul({real, 0.0}, complex)
  def mul({_, _} = complex, real), do: mul(complex, {real, 0.0})
  def mul(a, b), do: a * b

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | float, b :: complex | float) :: complex
  def add({a_real, a_imaginary}, {b_real, b_imaginary}) do
    {a_real + b_real, a_imaginary + b_imaginary}
  end

  def add(real, {_, _} = complex), do: add({real, 0.0}, complex)
  def add({_, _} = complex, real), do: add(complex, {real, 0.0})
  def add(a, b), do: a + b

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | float, b :: complex | float) :: complex
  def sub({a_real, a_imaginary}, {b_real, b_imaginary}) do
    {a_real - b_real, a_imaginary - b_imaginary}
  end

  def sub(real, {_, _} = complex), do: sub({real, 0.0}, complex)
  def sub({_, _} = complex, real), do: sub(complex, {real, 0.0})
  def sub(a, b), do: a - b

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | float, b :: complex | float) :: complex
  def div({a_real, a_imaginary}, {b_real, b_imaginary}) do
    denominator = pow(b_real, 2) + pow(b_imaginary, 2)
    real = (a_real * b_real + a_imaginary * b_imaginary) / denominator
    imaginary = (a_imaginary * b_real - a_real * b_imaginary) / denominator
    {real, imaginary}
  end

  def div(real, {_, _} = complex), do: div({real, 0.0}, complex)
  def div({_, _} = complex, real), do: div(complex, {real, 0.0})
  def div(a, b), do: a / b

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: float
  def abs({real, imaginary}) do
    sqrt(pow(real, 2) + pow(imaginary, 2))
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({real, imaginary}) do
    {real, -imaginary}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({real, imaginary}) do
    real_part = :math.exp(real) * cos(imaginary)
    imaginary_part = :math.exp(real) * sin(imaginary)
    {real_part, imaginary_part}
  end
end
