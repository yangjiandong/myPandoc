docker run \
        -it \
        --rm \
        -v ${PWD}:/resume \
        -e DISPLAY \
        there4/markdown-resume
        # \
        # xvfb-run md2resume pdf demo/markdown-resume/sample.md out/
