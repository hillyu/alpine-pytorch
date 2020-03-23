FROM scipy-alpine:test
LABEL maintainer="Juliano Petronetto <juliano@petronetto.com.br>" \
	name="PyTorch Alpine" \
	description="PyTorch in Alpine Linux" \
	url="https://hub.docker.com/r/petronetto/pytorch-alpine" \
	vcs-url="https://github.com/petronetto/pytorch-alpine" \
	vendor="Petronetto DevTech" \
	version="1.0"
	
RUN echo "|--> Updating" \
	&& apk update && apk upgrade \
    && apk add --no-cache --virtual=.build-deps \
         git \
	&& echo "|--> Install PyTorch" \
	&& git clone --recursive https://github.com/pytorch/pytorch \
	&& cd pytorch && python setup.py install \
	&& echo "|--> Install Torch Vision" \
	&& git clone --recursive https://github.com/pytorch/vision \
	&& cd vision && python setup.py install \
	&& echo "|--> Cleaning" \
	&& rm -rf /pytorch \
	&& rm -rf /root/.cache \
	&& rm -rf /var/cache/apk/* \
	&& apk del .build-deps \
	&& find /usr/lib -name __pycache__ | xargs rm -r \
	&& rm -rf /root/.[acpw]*
	
EXPOSE 5000
	
#WORKDIR /notebooks
	
#CMD ["jupyter", "notebook", "--port=5000", "--no-browser", \
	#"--allow-root", "--ip=0.0.0.0", "--NotebookApp.token="]
