function  [h] = generateHistogram(image)
h = histogram(image(:));
end