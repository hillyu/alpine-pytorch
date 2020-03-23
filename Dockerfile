FROM hillyu/alpine-python3-scipy-base:latest
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
	
#CMD ["jupyter", "notebook", "--port=5000", "--no-browser", \
	#"--allow-root", "--ip=0.0.0.0", "--NotebookApp.token="]
