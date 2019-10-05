#!/bin/bash

# Load xmodmap untuk membuat keys vim h,j,k,l menggantikan arrow keys secara global sampai ke system menggunakan ALT + h/j/k/l

user=nito

xmodmap /home/$user/.i3/scripts/.xmodmap
