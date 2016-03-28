class wikiedu::dependencies(
    $packages,
) {
    include ::git
    require ::nodesource

    ensure_resource('package', $packages, { ensure => installed })
}
