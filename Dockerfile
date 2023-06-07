# syntax=docker/dockerfile:1

FROM python:3.8
WORKDIR /app
RUN mkdir onnx_quantized_qa_model
RUN curl -o onnx_quantized_qa_model/config.json https://dvc-qa-model.s3.amazonaws.com/onnx_quantized_qa_model/config.json
RUN curl -o onnx_quantized_qa_model/special_tokens_map.json https://dvc-qa-model.s3.amazonaws.com/onnx_quantized_qa_model/special_tokens_map.json
RUN curl -o onnx_quantized_qa_model/spiece.model https://dvc-qa-model.s3.amazonaws.com/onnx_quantized_qa_model/spiece.model
RUN curl -o onnx_quantized_qa_model/t5_abs_qa-decoder-quantized.onnx https://dvc-qa-model.s3.amazonaws.com/onnx_quantized_qa_model/t5_abs_qa-decoder-quantized.onnx
RUN curl -o onnx_quantized_qa_model/t5_abs_qa-encoder-quantized.onnx https://dvc-qa-model.s3.amazonaws.com/onnx_quantized_qa_model/t5_abs_qa-encoder-quantized.onnx
RUN curl -o onnx_quantized_qa_model/t5_abs_qa-init-decoder-quantized.onnx https://dvc-qa-model.s3.amazonaws.com/onnx_quantized_qa_model/t5_abs_qa-init-decoder-quantized.onnx
RUN curl -o onnx_quantized_qa_model/tokenizer_config.json https://dvc-qa-model.s3.amazonaws.com/onnx_quantized_qa_model/tokenizer_config.json
RUN curl -o onnx_quantized_qa_model/tokenizer.json https://dvc-qa-model.s3.amazonaws.com/onnx_quantized_qa_model/tokenizer.json
COPY requirement.txt requirement.txt
RUN pip3 install https://download.pytorch.org/whl/cpu/torch-1.13.1%2Bcpu-cp38-cp38-linux_x86_64.whl
RUN pip3 install fastt5
RUN pip3 install onnxruntime
RUN pip3 install onnx
RUN pip3 install -r requirement.txt --no-cache-dir
COPY app.py .
COPY onnx_qa_model.py .
EXPOSE 5000
CMD [ "python", "app.py"]