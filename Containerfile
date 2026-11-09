FROM i.anatase.org/anatase:stable

# Do your thing...
# Install btop
# RUN dnf -y install btop

# Install coolercontrol
# RUN . /etc/os-release && \
#     dnf -y copr enable codifryed/CoolerControl && \
#     dnf -y install coolercontrol && \
#     systemctl enable coolercontrold

# Cleanup (leave this here)
RUN rm -rf /var && \
    mkdir -p /var/tmp
