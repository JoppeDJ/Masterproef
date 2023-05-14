%% Set data for comparison experiments: 10 10 10 5 3 3

r_vals = [20 40 60 80 100 120];

Jerror = [0.5010 0.3227 0.2274 0.2157 0.2031 0.2118];

Ferror = [0.0664 0.0233 0.0158 0.0113 0.0080 0.0076];

Acc_drops_CMTF_PT2 = [13.41 2.81 1.24 0.97 1.06 0.97];

Acc_drops_CTD_BIAS = 91.52 - [52.77 85.03 86.71 88.34 87.32 89.17];

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

%% Only accuracy drop: First plot

figure

semilogy(r_vals, Acc_drops_CMTF_PT2, '-o')

ylabel("Accuracy drop (%)", 'FontSize', 16)
xlabel("Flexibele neuronen per laag (FN)", 'FontSize', 16)

ax = gca;
ax.FontSize = 16;

yticks([0.97 1.45 5 10 100])
ylim([0.8 13.41])
hold on
semilogy(r_vals, Acc_drops_CTD_BIAS, '-o')

semilogy(r_vals, acc_drop_no, '-o')
semilogy(r_vals, acc_drop_ft, '--o')

legend("CMTF-PT2", "CTD-BIAS", "1 laag, geen FT", "1 laag, FT")

hold off
%% Set data for second comparision plot: 3 3 3 3 3 3

r_vals = [20 40 60 80 100 120];

Jerror = [0.5010 0.3227 0.2274 0.2157 0.2031 0.2118];

Ferror = [0.0664 0.0233 0.0158 0.0113 0.0080 0.0076];

Acc_drops_CMTF_PT2 = 91.52 - [75.22 88.34 90.05 90.23 90.27 89.67];

Acc_drops_CTD_BIAS = 91.52 - [50.60 84.80 85.92 87.92 88.78 89.05];

acc_drop_no = [12 6.2 5.9 5.6 3.8 3.4];

acc_drop_ft = [10 2.3 2.28 2.25 1.5 1.45];

%% Plot second comparison plot

figure

semilogy(r_vals, Acc_drops_CMTF_PT2, '-o')

ylabel("Accuracy drop (%)", 'FontSize', 16)
xlabel("Flexibele neuronen per laag (FN)", 'FontSize', 16)

ax = gca;
ax.FontSize = 16;

yticks([1.25 1.45 5 10 100])
ylim([0.8 13.41])
hold on
semilogy(r_vals, Acc_drops_CTD_BIAS, '-o')

semilogy(r_vals, acc_drop_no, '-o')
semilogy(r_vals, acc_drop_ft, '--o')

legend("CMTF-PT2", "CTD-BIAS", "1 laag, geen FT", "1 laag, FT")

hold off

%% Only accuracy drop

figure

semilogy(r_vals, Acc_drops_CMTF_PT2, '-o')

ylabel("Accuracy drop (%)", 'FontSize', 16)
xlabel("Flexibele neuronen per laag (FN)", 'FontSize', 16)

ax = gca;
ax.FontSize = 16;

yticks([0.97 1.45 5 10 100])
ylim([0.8 13.41])
hold on
semilogy(r_vals, Acc_drops_CTD_BIAS, '-o')

semilogy(r_vals, acc_drop_no, '-o')
semilogy(r_vals, acc_drop_ft, '--o')

legend("CMTF-PT2", "CTD-BIAS", "1 laag, geen FT", "1 laag, FT")

hold off

%% Compression ratio for 2 layers vs 1 layer

figure

semilogy(r_vals, 100 - Comp_ratio, '--*')
ax = gca;
ax.FontSize = 16;
ylabel("Comprimerings ratio (%)")
xlabel("Flexibele neuronen per laag", 'FontSize', 16)


%% Plots for checking effects of changing number of nodes per layer

x_values = [40 60 80 100];

% CTD-BIAS

% Data for r1 = 40

AccD_CTD_BIAS_40_1 = 91.52 - [84.74 87.30 86.07 86.11];
AccD_CTD_BIAS_40_2 = 91.52 - [84.88 85.48 86.03 86.98];
AccD_CTD_BIAS_40_3 = 91.52 - [85.13 86.03 85.90 87.09];

Jerror_CTD_BIAS_40_1 = [0.2556 0.2208 0.2022 0.1969];
Jerror_CTD_BIAS_40_2 = [0.2573 0.2202 0.2009 0.1928];
Jerror_CTD_BIAS_40_3 = [0.2546 0.2161 0.2004 0.1956];

Ferror_CTD_BIAS_40_1 = [0.0394 0.0284 0.0233 0.0209];
Ferror_CTD_BIAS_40_2 = [0.0398 0.0293 0.0214 0.0190];
Ferror_CTD_BIAS_40_3 = [0.0388 0.0263 0.0228 0.0200];

AccD_CTD_BIAS_40_avg = mean([AccD_CTD_BIAS_40_1; ...
    AccD_CTD_BIAS_40_2; ...
    AccD_CTD_BIAS_40_3]);

Jerror_CTD_BIAS_40_avg = mean([Jerror_CTD_BIAS_40_1; ...
    Jerror_CTD_BIAS_40_2; ...
    Jerror_CTD_BIAS_40_3]);

Ferror_CTD_BIAS_40_avg = mean([Ferror_CTD_BIAS_40_1; ...
    Ferror_CTD_BIAS_40_2; ...
    Ferror_CTD_BIAS_40_3]);

% Data for r1 = 60

AccD_CTD_BIAS_60_1 = 91.52 - [85.74 88.01 87.34 89.11];
AccD_CTD_BIAS_60_2 = 91.52 - [85.40 85.98 87.17 88.11];
AccD_CTD_BIAS_60_3 = 91.52 - [86.48 86.17 86.57 87.50];

Jerror_CTD_BIAS_60_1 = [0.2476 0.2149 0.2018 0.1885];
Jerror_CTD_BIAS_60_2 = [0.2527 0.2172 0.2028 0.1907];
Jerror_CTD_BIAS_60_3 = [0.2493 0.2197 0.1995 0.1899];

Ferror_CTD_BIAS_60_1 = [0.0331 0.0249 0.0223 0.0162];
Ferror_CTD_BIAS_60_2 = [0.0359 0.0260 0.0214 0.0188];
Ferror_CTD_BIAS_60_3 = [0.0344 0.0268 0.0211 0.0184];

AccD_CTD_BIAS_60_avg = mean([AccD_CTD_BIAS_60_1; ...
    AccD_CTD_BIAS_60_2; ...
    AccD_CTD_BIAS_60_3]);

Jerror_CTD_BIAS_60_avg = mean([Jerror_CTD_BIAS_60_1; ...
    Jerror_CTD_BIAS_60_2; ...
    Jerror_CTD_BIAS_60_3]);

Ferror_CTD_BIAS_60_avg = mean([Ferror_CTD_BIAS_60_1; ...
    Ferror_CTD_BIAS_60_2; ...
    Ferror_CTD_BIAS_60_3]);

% Data for r1 = 80

AccD_CTD_BIAS_80_1 = 91.52 - [87.40 87.71 88.65 88.51];
AccD_CTD_BIAS_80_2 = 91.52 - [87.23 88.63 88.19 88.76];
AccD_CTD_BIAS_80_3 = 91.52 - [85.51 87.32 89.28 89.42];

Jerror_CTD_BIAS_80_1 = [0.2393 0.2143 0.1996 0.1906];
Jerror_CTD_BIAS_80_2 = [0.2444 0.2129 0.2006 0.1915];
Jerror_CTD_BIAS_80_3 = [0.2412 0.2135 0.1982 0.1873];

Ferror_CTD_BIAS_80_1 = [0.0282 0.0240 0.0198 0.0183];
Ferror_CTD_BIAS_80_2 = [0.0304 0.0240 0.0202 0.0177];
Ferror_CTD_BIAS_80_3 = [0.0295 0.0235 0.0186 0.0158];

AccD_CTD_BIAS_80_avg = mean([AccD_CTD_BIAS_80_1; ...
    AccD_CTD_BIAS_80_2; ...
    AccD_CTD_BIAS_80_3]);

Jerror_CTD_BIAS_80_avg = mean([Jerror_CTD_BIAS_80_1; ...
    Jerror_CTD_BIAS_80_2; ...
    Jerror_CTD_BIAS_80_3]);

Ferror_CTD_BIAS_80_avg = mean([Ferror_CTD_BIAS_80_1; ...
    Ferror_CTD_BIAS_80_2; ...
    Ferror_CTD_BIAS_80_3]);


% CMTF-PT2

% Data for r1 = 40

AccD_CMTF_PT2_40_1 = 91.52 - [88.26 89.71 89.80 89.96];
AccD_CMTF_PT2_40_2 = 91.52 - [88.23 89.94 89.82 90.00];
AccD_CMTF_PT2_40_3 = 91.52 - [88.34 89.75 89.94 90.13];

Jerror_CMTF_PT2_40_1 = [0.2713 0.2298 0.2172 0.2059];
Jerror_CMTF_PT2_40_2 = [0.2692 0.2350 0.2104 0.2049];
Jerror_CMTF_PT2_40_3 = [0.2729 0.2316 0.2130 0.2080];

Ferror_CMTF_PT2_40_1 = [0.0283 0.0196 0.0167 0.0147];
Ferror_CMTF_PT2_40_2 = [0.0272 0.0203 0.0147 0.0140];
Ferror_CMTF_PT2_40_3 = [0.0287 0.0184 0.0157 0.0143];

AccD_CMTF_PT2_40_avg = mean([AccD_CMTF_PT2_40_1; ...
    AccD_CMTF_PT2_40_2; ...
    AccD_CMTF_PT2_40_3]);

Jerror_CMTF_PT2_40_avg = mean([Jerror_CMTF_PT2_40_1; ...
    Jerror_CMTF_PT2_40_2; ...
    Jerror_CMTF_PT2_40_3]);

Ferror_CMTF_PT2_40_avg = mean([Ferror_CMTF_PT2_40_1; ...
    Ferror_CMTF_PT2_40_2; ...
    Ferror_CMTF_PT2_40_3]);


% Data for r1 = 60

AccD_CMTF_PT2_60_1 = 91.52 - [89.38 90.17 90.40 90.25];
AccD_CMTF_PT2_60_2 = 91.52 - [88.69 90.03 90.36 90.42];
AccD_CMTF_PT2_60_3 = 91.52 - [89.19 90.03 90.57 90.28];

Jerror_CMTF_PT2_60_1 = [0.2635 0.2341 0.2149 0.2004];
Jerror_CMTF_PT2_60_2 = [0.2703 0.2283 0.2180 0.2031];
Jerror_CMTF_PT2_60_3 = [0.2669 0.2319 0.2130 0.2097];

Ferror_CMTF_PT2_60_1 = [0.0202 0.0149 0.0124 0.010];
Ferror_CMTF_PT2_60_2 = [0.0218 0.0147 0.0115 0.0103];
Ferror_CMTF_PT2_60_3 = [0.0212 0.0151 0.0115 0.0111];

AccD_CMTF_PT2_60_avg = mean([AccD_CMTF_PT2_60_1; ...
    AccD_CMTF_PT2_60_2; ...
    AccD_CMTF_PT2_60_3]);

Jerror_CMTF_PT2_60_avg = mean([Jerror_CMTF_PT2_60_1; ...
    Jerror_CMTF_PT2_60_2; ...
    Jerror_CMTF_PT2_60_3]);

Ferror_CMTF_PT2_60_avg = mean([Ferror_CMTF_PT2_60_1; ...
    Ferror_CMTF_PT2_60_2; ...
    Ferror_CMTF_PT2_60_3]);

% Data for r1 = 80

AccD_CMTF_PT2_80_1 = 91.52 - [89.71 90.55 90.34 90.61];
AccD_CMTF_PT2_80_2 = 91.52 - [89.78 90.30 90.44 90.41];
AccD_CMTF_PT2_80_3 = 91.52 - [89.61 90.42 90.36 90.65];

Jerror_CMTF_PT2_80_1 = [0.2600 0.2317 0.2121 0.2052];
Jerror_CMTF_PT2_80_2 = [0.2648 0.2268 0.2159 0.2055];
Jerror_CMTF_PT2_80_3 = [0.2618 0.2278 0.2104 0.2005];

Ferror_CMTF_PT2_80_1 = [0.0160 0.0124 0.0099 0.0085];
Ferror_CMTF_PT2_80_2 = [0.0171 0.0113 0.0101 0.0096];
Ferror_CMTF_PT2_80_3 = [0.0171 0.0115 0.0100 0.0091];

AccD_CMTF_PT2_80_avg = mean([AccD_CMTF_PT2_80_1; ...
    AccD_CMTF_PT2_80_2; ...
    AccD_CMTF_PT2_80_3]);

Jerror_CMTF_PT2_80_avg = mean([Jerror_CMTF_PT2_80_1; ...
    Jerror_CMTF_PT2_80_2; ...
    Jerror_CMTF_PT2_80_3]);

Ferror_CMTF_PT2_80_avg = mean([Ferror_CMTF_PT2_80_1; ...
    Ferror_CMTF_PT2_80_2; ...
    Ferror_CMTF_PT2_80_3]);

%% Plots for CTD-BIAS

%% r1 = 40

subplot(1,3,2);

semilogy(x_values, Jerror_CTD_BIAS_40_1, '-x')
title("Tensor NMSE")

hold on

semilogy(x_values, Jerror_CTD_BIAS_40_2, '-x')
semilogy(x_values, Jerror_CTD_BIAS_40_3, '-x')

yticks([ 0.2 0.22 0.24 0.26 0.28 0.3 0.32 0.34 0.36 0.38 0.4 0.42 0.44 0.46 0.48 0.5 0.52])
ylim([0.2031 0.5010])

hold off


subplot(1,3,3);

semilogy(x_values, Ferror_CTD_BIAS_40_1, '-d')
title("Matrix NMSE")

hold on

semilogy(x_values, Ferror_CTD_BIAS_40_2, '-d')
semilogy(x_values, Ferror_CTD_BIAS_40_3, '-d')

yticks([0.02 0.03 0.04 0.05 0.06])
ylim([0.0076 0.0664])

hold off

subplot(1,3,1);

semilogy(x_values, AccD_CTD_BIAS_40_1, '-o')
title("Accuracy drop")

hold on

semilogy(x_values, AccD_CTD_BIAS_40_2, '-o')
semilogy(x_values, AccD_CTD_BIAS_40_3, '-o')

yticks([0.97 1.45 5 10 100])
ylim([0.8 13.41])

%legend("2 layers, no FT", "1 layer, no FT", "1 layer, FT")

hold off

%% r1 = 60

subplot(1,3,2);

semilogy(x_values, Jerror_CTD_BIAS_60_1, '-x')
title("Tensor NMSE")

hold on

semilogy(x_values, Jerror_CTD_BIAS_60_2, '-x')
semilogy(x_values, Jerror_CTD_BIAS_60_3, '-x')

yticks([ 0.2 0.22 0.24 0.26 0.28 0.3 0.32 0.34 0.36 0.38 0.4 0.42 0.44 0.46 0.48 0.5 0.52])
ylim([0.2031 0.5010])

hold off


subplot(1,3,3);

semilogy(x_values, Ferror_CTD_BIAS_60_1, '-d')
title("Matrix NMSE")

hold on

semilogy(x_values, Ferror_CTD_BIAS_60_2, '-d')
semilogy(x_values, Ferror_CTD_BIAS_60_3, '-d')

yticks([0.02 0.03 0.04 0.05 0.06])
ylim([0.0076 0.0664])

hold off

subplot(1,3,1);

semilogy(x_values, AccD_CTD_BIAS_60_1, '-o')
title("Accuracy drop")

hold on

semilogy(x_values, AccD_CTD_BIAS_60_2, '-o')
semilogy(x_values, AccD_CTD_BIAS_60_3, '-o')

yticks([0.97 1.45 5 10 100])
ylim([0.8 13.41])

%legend("2 layers, no FT", "1 layer, no FT", "1 layer, FT")

hold off


%% r1 = 80

subplot(1,3,2);

semilogy(x_values, Jerror_CTD_BIAS_80_1, '-x')
title("Tensor NMSE")

yticks([ 0.2 0.22 0.24 0.26 0.28 0.3 0.32 0.34 0.36 0.38 0.4 0.42 0.44 0.46 0.48 0.5 0.52])
ylim([0.2031 0.5010])

hold on

semilogy(x_values, Jerror_CTD_BIAS_80_2, '-x')
semilogy(x_values, Jerror_CTD_BIAS_80_3, '-x')



hold off


subplot(1,3,3);

semilogy(x_values, Ferror_CTD_BIAS_80_1, '-d')
title("Matrix NMSE")

yticks([0.02 0.03 0.04 0.05 0.06])
ylim([0.0076 0.0664])

hold on

semilogy(x_values, Ferror_CTD_BIAS_80_2, '-d')
semilogy(x_values, Ferror_CTD_BIAS_80_3, '-d')



hold off

subplot(1,3,1);

semilogy(x_values, AccD_CTD_BIAS_80_1, '-o')
title("Accuracy drop")

yticks([0.97 1.45 5 10 100])
ylim([0.8 13.41])

hold on

semilogy(x_values, AccD_CTD_BIAS_80_2, '-o')
semilogy(x_values, AccD_CTD_BIAS_80_3, '-o')

%legend("2 layers, no FT", "1 layer, no FT", "1 layer, FT")

hold off

%% Plots averages CTD-BIAS

subplot(1,3,2);

semilogy(x_values, Jerror_CTD_BIAS_40_avg, '-x')
title("Tensor NMSE")

yticks([ 0.2 0.22 0.24 0.26 0.28 0.3 0.32 0.34 0.36 0.38 0.4 0.42 0.44 0.46 0.48 0.5 0.52])
ylim([0.2031 0.5010])

hold on

semilogy(x_values, Jerror_CTD_BIAS_60_avg, '-x')
semilogy(x_values, Jerror_CTD_BIAS_80_avg, '-x')



hold off


subplot(1,3,3);

semilogy(x_values, Ferror_CTD_BIAS_40_avg, '-d')
title("Matrix NMSE")

yticks([0.02 0.03 0.04 0.05 0.06])
ylim([0.0076 0.0664])

hold on

semilogy(x_values, Ferror_CTD_BIAS_60_avg, '-d')
semilogy(x_values, Ferror_CTD_BIAS_80_avg, '-d')



hold off

subplot(1,3,1);

semilogy(x_values, AccD_CTD_BIAS_40_avg, '-o')
title("Accuracy drop")

yticks([0.97 1.45 5 10 100])
ylim([0.8 13.41])

hold on

semilogy(x_values, AccD_CTD_BIAS_60_avg, '-o')
semilogy(x_values, AccD_CTD_BIAS_80_avg, '-o')

legend("r_1 = 40", "r_1 = 60", "r_1 = 80")

hold off

%% Plots for CMTF-PT2

%% r1 = 40

subplot(1,3,2);

semilogy(x_values, Jerror_CMTF_PT2_40_1, '-x')
title("Tensor NMSE")

hold on

semilogy(x_values, Jerror_CMTF_PT2_40_2, '-x')
semilogy(x_values, Jerror_CMTF_PT2_40_3, '-x')

yticks([ 0.2 0.22 0.24 0.26 0.28 0.3 0.32 0.34 0.36 0.38 0.4 0.42 0.44 0.46 0.48 0.5 0.52])
ylim([0.2031 0.5010])

hold off


subplot(1,3,3);

semilogy(x_values, Ferror_CMTF_PT2_40_1, '-d')
title("Matrix NMSE")

hold on

semilogy(x_values, Ferror_CMTF_PT2_40_2, '-d')
semilogy(x_values, Ferror_CMTF_PT2_40_3, '-d')

yticks([0.02 0.03 0.04 0.05 0.06])
ylim([0.0076 0.0664])

hold off

subplot(1,3,1);

semilogy(x_values, AccD_CMTF_PT2_40_1, '-o')
title("Accuracy drop")

hold on

semilogy(x_values, AccD_CMTF_PT2_40_2, '-o')
semilogy(x_values, AccD_CMTF_PT2_40_3, '-o')

yticks([0.97 1.45 5 10 100])
ylim([0.8 13.41])


hold off

%% r1 = 60

subplot(1,3,2);

semilogy(x_values, Jerror_CMTF_PT2_60_1, '-x')
title("Tensor NMSE")

hold on

semilogy(x_values, Jerror_CMTF_PT2_60_2, '-x')
semilogy(x_values, Jerror_CMTF_PT2_60_3, '-x')

yticks([ 0.2 0.22 0.24 0.26 0.28 0.3 0.32 0.34 0.36 0.38 0.4 0.42 0.44 0.46 0.48 0.5 0.52])
ylim([0.2031 0.5010])

hold off


subplot(1,3,3);

semilogy(x_values, Ferror_CMTF_PT2_60_1, '-d')
title("Matrix NMSE")

hold on

semilogy(x_values, Ferror_CMTF_PT2_60_2, '-d')
semilogy(x_values, Ferror_CMTF_PT2_60_3, '-d')

yticks([0.02 0.03 0.04 0.05 0.06])
ylim([0.0076 0.0664])

hold off

subplot(1,3,1);

semilogy(x_values, AccD_CMTF_PT2_60_1, '-o')
title("Accuracy drop")

hold on

semilogy(x_values, AccD_CMTF_PT2_60_2, '-o')
semilogy(x_values, AccD_CMTF_PT2_60_3, '-o')

yticks([0.97 1.45 5 10 100])
ylim([0.8 13.41])

%legend("2 layers, no FT", "1 layer, no FT", "1 layer, FT")

hold off


%% r1 = 80

subplot(1,3,2);

semilogy(x_values, Jerror_CMTF_PT2_80_1, '-x')
title("Tensor NMSE")

yticks([ 0.2 0.22 0.24 0.26 0.28 0.3 0.32 0.34 0.36 0.38 0.4 0.42 0.44 0.46 0.48 0.5 0.52])
ylim([0.2031 0.5010])

hold on

semilogy(x_values, Jerror_CMTF_PT2_80_2, '-x')
semilogy(x_values, Jerror_CMTF_PT2_80_3, '-x')



hold off


subplot(1,3,3);

semilogy(x_values, Ferror_CMTF_PT2_80_1, '-d')
title("Matrix NMSE")

yticks([0.02 0.03 0.04 0.05 0.06])
ylim([0.0076 0.0664])

hold on

semilogy(x_values, Ferror_CMTF_PT2_80_2, '-d')
semilogy(x_values, Ferror_CMTF_PT2_80_3, '-d')



hold off

subplot(1,3,1);

semilogy(x_values, AccD_CMTF_PT2_80_1, '-o')
title("Accuracy drop")

yticks([0.97 1.45 5 10 100])
ylim([0.8 13.41])

hold on

semilogy(x_values, AccD_CMTF_PT2_80_2, '-o')
semilogy(x_values, AccD_CMTF_PT2_80_3, '-o')

%legend("2 layers, no FT", "1 layer, no FT", "1 layer, FT")

hold off

%% Plot averages CMTF-PT2

subplot(1,3,2);

semilogy(x_values, Jerror_CMTF_PT2_40_avg, '-x')
title("Tensor NMSE")

yticks([ 0.2 0.22 0.24 0.26 0.28 0.3 0.32 0.34 0.36 0.38 0.4 0.42 0.44 0.46 0.48 0.5 0.52])
ylim([0.2031 0.5010])

hold on

semilogy(x_values, Jerror_CMTF_PT2_60_avg, '-x')
semilogy(x_values, Jerror_CMTF_PT2_80_avg, '-x')



hold off


subplot(1,3,3);

semilogy(x_values, Ferror_CMTF_PT2_40_avg, '-d')
title("Matrix NMSE")

yticks([0.02 0.03 0.04 0.05 0.06])
ylim([0.0076 0.0664])

hold on

semilogy(x_values, Ferror_CMTF_PT2_60_avg, '-d')
semilogy(x_values, Ferror_CMTF_PT2_80_avg, '-d')



hold off

subplot(1,3,1);

semilogy(x_values, AccD_CMTF_PT2_40_avg, '-o')
title("Accuracy drop")

yticks([0.97 1.45 5 10 100])
ylim([0.8 13.41])

hold on

semilogy(x_values, AccD_CMTF_PT2_60_avg, '-o')
semilogy(x_values, AccD_CMTF_PT2_80_avg, '-o')

legend("r_1 = 40", "r_1 = 60", "r_1 = 80")

hold off


%% Set data for comparsion od dg and dh

x_values = [2 3 4 5 6];

AccD_dg_dh_1 = 91.52 - [90.25 90.69  90.34 90.50 90.42];
AccD_dg_dh_2 = 91.52 - [90.30 90.52  90.44 90.61 90.53];
AccD_dg_dh_3 = 91.52 - [90.50 90.52  90.36 90.59 90.61];

Jerror_dg_dh_1 = [0.2202 0.2207 0.2121 0.2126 0.2116];
Jerror_dg_dh_2 = [0.2274 0.2168 0.2159 0.2157 0.2081];
Jerror_dg_dh_3 = [0.2268 0.2252 0.2104 0.2148 0.2118];

Ferror_dg_dh_1 = [0.0107 0.0109 0.0099 0.0098 0.0104];
Ferror_dg_dh_2 = [0.0115 0.0107 0.0101 0.0104 0.0098];
Ferror_dg_dh_3 = [0.0114 0.0112 0.0100 0.0110 0.0104];

AccD_dg_dh_avg = mean([AccD_dg_dh_1; ...
    AccD_dg_dh_2; ...
    AccD_dg_dh_3], 1);

Jerror_dg_dh_avg = mean([Jerror_dg_dh_1; ...
    Jerror_dg_dh_2; ...
    Jerror_dg_dh_3], 1);

Ferror_dg_dh_avg = mean([Ferror_dg_dh_1; ...
    Ferror_dg_dh_2; ...
    Ferror_dg_dh_3], 1);

%% Plots for comparsion of dg and dh

subplot(1,3,2);

semilogy(x_values, Jerror_dg_dh_1, '-x')
title("Tensor NMSE")

yticks([ 0.2 0.22 0.24 0.26 0.28 0.3 0.32 0.34 0.36 0.38 0.4 0.42 0.44 0.46 0.48 0.5 0.52])
ylim([0.2031 0.5010])

hold on

semilogy(x_values, Jerror_dg_dh_2, '-x')
semilogy(x_values, Jerror_dg_dh_3, '-x')



hold off


subplot(1,3,3);

semilogy(x_values, Ferror_dg_dh_1, '-d')
title("Matrix NMSE")

yticks([0.02 0.03 0.04 0.05 0.06])
ylim([0.0076 0.0664])

hold on

semilogy(x_values, Ferror_dg_dh_2, '-d')
semilogy(x_values, Ferror_dg_dh_3, '-d')



hold off

subplot(1,3,1);

semilogy(x_values, AccD_dg_dh_1, '-o')
title("Accuracy drop")

yticks([0.97 1.45 5 10 100])
ylim([0.8 13.41])

hold on

semilogy(x_values, AccD_dg_dh_2, '-o')
semilogy(x_values, AccD_dg_dh_3, '-o')

%legend("2 layers, no FT", "1 layer, no FT", "1 layer, FT")

hold off

%% Plots of averages

subplot(1,3,2);

semilogy(x_values, Jerror_dg_dh_avg, '-x')
title("Tensor NMSE")

yticks([ 0.2 0.22 0.24 0.26 0.28 0.3 0.32 0.34 0.36 0.38 0.4 0.42 0.44 0.46 0.48 0.5 0.52])
ylim([0.2031 0.5010])


subplot(1,3,3);

semilogy(x_values, Ferror_dg_dh_avg, '-d')
title("Matrix NMSE")

yticks([0.02 0.03 0.04 0.05 0.06])
ylim([0.0076 0.0664])

subplot(1,3,1);

semilogy(x_values, AccD_dg_dh_avg, '-o')
title("Accuracy drop")

yticks([0.97 1.45 5 10 100])
ylim([0.8 13.41])

%legend("2 layers, no FT", "1 layer, no FT", "1 layer, FT")
