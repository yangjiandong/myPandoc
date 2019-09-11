cp output/book.pdf output/book/
rsync -e ssh -av output/book/* $GIT_BOOK_SSH_ADDR