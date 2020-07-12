# Image-processing
#### Xử lý ảnh trên miền tần số:

##### Các phép xử lý:

- Lý tưởng (Ideal)

  - Thông thấp
    $$
    H = D < D0
    $$

  - Thông cao
    $$
    H = 1 - (D<D0)
    $$
    

- Gaussian

  - Thông thấp
    $$
    H=e^{-c(D^2/D0^2)}
    $$
    

  - Thông cao 
    $$
    H=1 - e^{-c(D^2/D0^2)}
    $$
    

- Butterworth

  - Thông thấp
    $$
    H = \frac{1}{1+(D/D0)^{2n}}
    $$
    

  - Thông cao
    $$
    H = 1 - \frac{1}{1+(D/D0)^{2n}}
    $$
    

- Laplacian

  - Thông thấp
    $$
    H = D
    $$
    

  - Thông cao
    $$
    H=1-D
    $$
    

- Đồng hình (Homomorphie)
  $$
  H=({\gamma}_H - {\gamma}_L)[1-e^{-c(D^2/D0^2)}] + {\gamma}_L
  $$
  

###### Hàm xử lý:

- ```matlab
  low_frequency_filter(gray_image, filter_type, D0, n, c, gammaL, gammaH)
  ```

  - Tham số:
    - gray_image: ảnh đầu vào ở dạng ảnh mức xám
    - filter_type: loại filter sử dụng
    - D0: mức lọc tần số
    - n: độ nét của bộ lọc
    - c: tham số của phép lọc gaussian và đồng hình
    - gammaL, gammaH: tham số của phép lọc đồng hình
  - Trả về: ảnh sau khi xử lý

- ```matlab
  get_H(filter_type, D, D0, n, c, gammaL, gammaH)
  ```
  - Tham số như trên
  - Trả về: bộ lọc H tương ứng với filter_type

- ```matlab
  frequency_processing(gray_image, filter_type, H)
  ```

  - Tham số:
    - gray_image: Ảnh xám đầu vào
    - filter_type: loại phép lọc
    - H: bộ lọc
  - Trả về: ảnh sau khi xử lý