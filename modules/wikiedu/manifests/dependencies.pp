class wikiedu::dependencies(
    $packages,
) {
    include ::git

    ensure_resource('package', $packages, { ensure => installed })
}
