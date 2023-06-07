# syntax=docker/dockerfile:1

FROM python:3.8-slim

WORKDIR /app

COPY requirement.txt requirement.txt
RUN pip3 install https://download.pytorch.org/whl/cpu/torch-1.13.1%2Bcpu-cp38-cp38-linux_x86_64.whl
RUN pip3 install fastt5
RUN pip3 install onnxruntime
RUN pip3 install onnx
RUN pip3 install -r requirement.txt --no-cache-dir
COPY . .

EXPOSE 5000
CMD [ "python", "app.py"]