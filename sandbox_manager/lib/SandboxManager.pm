package SandboxManager;

use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by "my_app.conf"
  my $config = $self->plugin('Config');

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer') if $config->{perldoc};

  $self->plugin('TemplateToolkit');
  $self->plugin(TemplateToolkit => {template => {INTERPOLATE => 1}});
  $self->renderer->default_handler('tt2');

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('sandboxes#list');
  $r->get('/create')->to('sandboxes#create_form');
  $r->post('/create')->to('sandboxes#create_submit');
  $r->any('/provision_log/:name')->to('sandboxes#provision_log');
  $r->any('/docker_log/:name')->to('sandboxes#docker_log');
  $r->any('/koha_log/:name')->to('sandboxes#koha_log');
  $r->any('/delete/:name')->to('sandboxes#delete');
  $r->any('/restart_all/:name')->to('sandboxes#restart_all');
  $r->any('/reindex_full/:name')->to('sandboxes#reindex_full');
  $r->any('/clear_database/:name')->to('sandboxes#clear_database');
}

1;
