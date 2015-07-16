class wikiedu::dependencies(
    $packages,
) {
    include ::git
    include ::github

    ensure_resource('package', $packages, { ensure => installed })
}
