# syntax=docker/dockerfile:1

FROM python:3.8

RUN apt update
RUN apt install -y git
RUN pip3 install "dvc[s3]"

WORKDIR /app

COPY requirement.txt requirement.txt
RUN pip3 install https://download.pytorch.org/whl/cpu/torch-1.13.1%2Bcpu-cp38-cp38-linux_x86_64.whl
RUN pip3 install fastt5
RUN pip3 install onnxruntime
RUN pip3 install onnx
RUN pip3 install -r requirement.txt --no-cache-dir
COPY . .

RUN dvc remote modify qa-model access_key_id AKIAQZVDIT2LZ2G5ZLGW
RUN dvc remote modify qa-model secret_access_key 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
RUN dvc pull

EXPOSE 5000
CMD [ "python", "app.py"]