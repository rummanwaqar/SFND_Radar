# Radar Target Generation and Detection Project (Udacity Sensor Fusion ND)

## 2D CFAR 

#### Parameter selection

Training and guard cell size was selected with trial and error method. The following values gave us good results for the project

```
%Select the number of Training Cells in both the dimensions.
Tr = 10;
Td = 8;

%Select the number of Guard Cells in both dimensions around the Cell under 
%test (CUT) for accurate estimation
Gr = 4;
Gd = 4;
```

The offset was selected by looking at the average error in the 2D FFT Range Doppler Map.

```
offset = 20;
```

#### Implementation steps

1. Iterate over the grid.
2. For each CUT in grid calculate the theshold by averaging each training cell and adding the offset.
3. Compare the CUT against the threshold and assign value of 1 if it is greater than the threshold, otherwise set it to zero.


```
for i = Tr+Gr+1:(Nr/2)-(Gr+Tr)
   for j = Td+Gd+1:Nd-(Gd+Td)    
       
       %Create a vector to store noise_level for each iteration on training cells
       noise_level = zeros(1,1);
       
       % sum in area around CUT
       for p = i-(Tr+Gr):i+Tr+Gr
          for q = j-(Td+Gd):j+Td+Gd
              if (abs(i-p)>Gr || abs(j-q)>Gd)
                  noise_level = noise_level + db2pow(RDM(p,q));
              end
          end
       end
       
       
       % Calculate threshold
       threshold = pow2db(noise_level/(2*(Td+Gd+1)*2*(Tr+Gr+1)-(Gr*Gd)-1));
       threshold = threshold + offset;
        
       if (RDM(i, j) < threshold)
          RDM(i, j) = 0;
       else
          RDM(i, j) = 1;
       end
   end
end
```

#### Suppression of non-thresholded cells at the edge

To suppress the cells at the edge we just set them all to zero

```
RDM(1:(Tr+Gr),:) = 0;
RDM(end-(Tr+Gr-1):end,:) = 0;
RDM(:,1:Td+Gd) = 0;
RDM(:,end-(Td+Gd-1):end) = 0;
```
