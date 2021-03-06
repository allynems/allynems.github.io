---
title: CAPE Forum 2020
layout: default
---

[Abstract:](dos-Santos.pdf)

*Surrogate optimization is the approximation of an objective function, in this work the steady-state cost gradient, with a suitable function approximator to use in process optimization. This model is used in the attempt to reach an optimum, which means that the estimated gradient must be driven into zero. The closed-loop surrogate optimization can be executed by estimating the gradient from available measurements (Krishnamoorthy, 2019). The surrogate model for the gradient needs to have good online performance (i.e. achieve fast convergence), account for uncertainty and do not diverge nor have an offset when the system goes out of domain region used for training. This work consists of a study on the trade-off between using a simple, but not as accurate, surrogate model and using more complicated machine learning techniques when it comes to closed-loop surrogate optimizer from available measurements of a nonlinear system.*

*Another matter is the quantity of available data and tendency of linear models to have high bias error. These are two of the several reasons that a design of computational experiments is necessary. To address this issue, this work also contains a study of the quantity of training data that is needed for the identification to have acceptable accuracy. There are several techniques developed specially to computational design. Giunta et al. (2003) made a review of some of the modern ones: Monte Carlo sampling and its variants (such as latin hypercube sampling, pseudo-Monte Carlo sampling, orthogonal array sampling), and quasi-Monte Carlo sampling. The method used in this work was the latin hypercube sampling (LHS) due to its easy way to implement and effectiveness.*

*In this work, we estimate the gradient of a heat exchanger network (Jäschke and Skogestad, 2014) using different types of methods and compare them in online closed-loop performance. The case study presents nonlinear behavior, in the presence of disturbance and noise. The example was approached in four scenarios, that differs on which disturbances have its measurement available. The methods used in this work were principal component regression (PCR), partial least square regression (PLSR) and support vector regression. As the example is nonlinear, prior knowledge was manually inserted beforehand in the inputs of PCR and PLSR models as nonlinear transformations between available measurements and compared with the plain linear models.*


<a href="https://github.com/allynems/allynems.github.io/tree/main/Presentations/2019_cape-forum/code" class="link">Click here</a> to see how the project was executed.

Presentation slides:
<iframe src="https://studntnu-my.sharepoint.com/personal/allyned_ntnu_no/_layouts/15/Doc.aspx?sourcedoc={d85102b0-c967-4047-9db0-0a84e197654c}&amp;action=embedview&amp;wdAr=1.7777777777777777" width="350px" height="221px" frameborder="0">This is an embedded <a target="_blank" href="https://office.com">Microsoft Office</a> presentation, powered by <a target="_blank" href="https://office.com/webapps">Office</a>.</iframe>
