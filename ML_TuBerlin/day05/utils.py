import matplotlib.pyplot as plt
import numpy as np
""" Code based on 
https://stackoverflow.com/questions/61811084/plotting-orthogonal-distances-in-python
"""

def plot_svm(X, y, clf):
  plt.scatter(X[:, 0], X[:, 1], c=y, s=30, cmap=plt.cm.Paired)

  # plot the decision function
  ax = plt.gca()
  xlim = ax.get_xlim()
  ylim = ax.get_ylim()

  # create grid to evaluate model
  xx = np.linspace(xlim[0], xlim[1], 30)  # {ndarray: (30,)}
  yy = np.linspace(ylim[0], ylim[1], 30)  # {ndarray: (30,)}
  YY, XX = np.meshgrid(yy, xx)  # {ndarray: (30,30)}, {ndarray: (30,30)}
  xy = np.vstack([XX.ravel(), YY.ravel()]).T  # # {ndarray: (900, 2)},
  Z = clf.decision_function(xy).reshape(XX.shape)  # {ndarray: (30,30)}

  # plot decision boundary and margins
  ax.contour(XX, YY, Z, colors='k', levels=[-1, 0, 1], alpha=0.5,
           linestyles=['--', '-', '--'])
  # plot support vectors
  ax.scatter(clf.support_vectors_[:, 0], clf.support_vectors_[:, 1], s=100,
           linewidth=1, facecolors='none', edgecolors='k')
  plt.show()

    
def abline(slope, intercept, x_vals=None, label=''):
  """Plot a line from slope and intercept"""
  if x_vals is None:
    axes = plt.gca()
    # print(axes.get_xlim())
    x_vals = np.array(axes.get_xlim())
  y_vals = intercept + slope * x_vals
  plt.plot(x_vals, y_vals, '--', label=label)


