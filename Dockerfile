FROM sachinruk/miniconda3
WORKDIR /
RUN apt update && apt -y install curl git wget
# Copies the trainer code to the docker image.
COPY trainer /trainer
# Sets up the entry point to invoke the trainer.
EXPOSE 8080
ENTRYPOINT ["python", "-m", "trainer.task"]
CMD ["--http-port=8080"]
