x = dlarray(-10:0.1:10);

y1 = extractdata(sigmoid(x));
y2 = extractdata(relu(x));
y3 = extractdata(tanh(x));

x = extractdata(x);

figure

subplot(1,3,1);
plot(x,y1,'LineWidth',2, 'Color', 'r');
ylim([-0.2 1.2])
xlabel("x", 'fontsize', 10)
ylabel("sigmoid(x)", 'fontsize', 10)

subplot(1,3,2);
plot(x,y2,'LineWidth',2, 'Color', 'r');
ylim([-0.9 5])
xlabel("x", 'fontsize', 10)
ylabel("ReLU(x)", 'fontsize', 10)

subplot(1,3,3);
plot(x,y3,'LineWidth',2, 'Color', 'r');
ylim([-1.4 1.2])
xlabel("x", 'fontsize', 10)
ylabel("tanh(x)", 'fontsize', 10)

