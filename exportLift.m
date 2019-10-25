% export data at 25mm interval for span axis
Lift = Lift / 9.81;
delta_alpha = delta_alpha / pi * 180;
i = 1;
j = 1;

for i = 1: b/2/25+1
  while i * 25 > x(j)
    j = j + 1;
    if j == N + 1
      break;
    end
    
  end
  LiftOut(i) = (x(j) - i * 25) * Lift(j-1) + (i * 25 - x(j - 1)) * Lift(j);
  LiftOut(i) = LiftOut(i) / (x(j) - x(j-1));
  delta_alphaOut(i) = (x(j) - i * 25) * delta_alpha(j-1) + (i * 25 - x(j - 1)) * delta_alpha(j);
  delta_alphaOut(i) = delta_alphaOut(i) / (x(j) - x(j-1));
  j = 1;
endfor

OutData = zeros(b / 2 / 25 + 1, 3);

for i = 1: b/2/25 + 1
  OutData(i, 1) = (i - 1) * 25;
endfor

OutData(:, 2) = LiftOut;
OutData(:, 3) = delta_alphaOut;
csvwrite('OutData.csv', OutData);
