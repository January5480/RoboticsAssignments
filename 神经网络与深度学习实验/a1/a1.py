import random
import torch
from d2l import torch as d2l


def synthetic_data(w, b, num_examples):
    """生成y = Xw + b"""
    X = torch.normal(0, 1, (num_examples, len(w)))
    y = torch.matmul(X, w) + b
    y += torch.normal(0, 0.01, y.shape)
    return X, y.reshape((-1, 1))

true_w = torch.tensor([2, -3.4])
true_b = 4.2
feature, labels = synthetic_data(true_w, true_b, 1000)
print('features', feature[0], '\nlabel:', labels[0])

d2l.set_figsize()
d2l.plt.scatter(feature[:, (1)].detach().numpy(), labels.detach().numpy(), 1)
d2l.plt.show()