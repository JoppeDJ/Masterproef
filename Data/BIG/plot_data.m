%% Set data

r_vals = [20 40 60 80 100 120];

Jerror = [0.5010 0.3227 0.2274 0.2157 0.2031 0.2118];

Ferror = [0.0664 0.0233 0.0158 0.0113 0.0080 0.0076];

Acc_drops = [13.41 2.81 1.24 0.97 1.06 0.97];

acc_drop_no = [12 6.2 5.9 5.6 3.8 3.4];

acc_drop_ft = [10 2.3 2.28 2.25 1.5 1.45];

Comp_ratio = [4 8 12 16 20 24];

%% Plot figures

%% Subplot of accuracy drop, tensor NMSE and matrix NMSE

subplot(1,3,2);

semilogy(r_vals, Jerror, '-x')

title("Tensor NMSE")

yticks([ 0.2 0.22 0.24 0.26 0.28 0.3 0.32 0.34 0.36 0.38 0.4 0.42 0.44 0.46 0.48 0.5 0.52])
ylim([0.2031 0.5010])

subplot(1,3,3);
semilogy(r_vals, Ferror, '-d')

title("Matrix NMSE")

yticks([0.02 0.03 0.04 0.05 0.06])
ylim([0.0076 0.0664])

subplot(1,3,1);
semilogy(r_vals, Acc_drops, '-o')

title("Accuracy drop")

yticks([0.97 1.45 5 10 100])
ylim([0.8 13.41])
hold on
semilogy(r_vals, acc_drop_no, '-o')
semilogy(r_vals, acc_drop_ft, '--o')

legend("2 layers, no FT", "1 layer, no FT", "1 layer, FT")

hold off

%% Only accuracy drop

figure

semilogy(r_vals, Acc_drops, '-o')

ylabel("Accuracy drop (%)", 'FontSize', 16)
xlabel("Flexibele neuronen per laag (FN)", 'FontSize', 16)

ax = gca;
ax.FontSize = 16;

yticks([0.97 1.45 5 10 100])
ylim([0.8 13.41])
hold on
semilogy(r_vals, acc_drop_no, '-o')
semilogy(r_vals, acc_drop_ft, '--o')

legend("2 lagen, geen FT", "1 laag, geen FT", "1 laag, FT")

hold off

%% Compression ratio for 2 layers vs 1 layer

figure

semilogy(r_vals, 100 - Comp_ratio, '--*')
ax = gca;
ax.FontSize = 16;
ylabel("Comprimerings ratio (%)")
xlabel("Flexibele neuronen per laag", 'FontSize', 16)