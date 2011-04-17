package State;

BEGIN {
  use base qw(Exporter);
  our @EXPORT = ();
}

sub new {
  my ($class, %obj_attr) = @_;
  my $state_obj = \%obj_attr;
  bless $state_obj, $class;
  return $state_obj;
}

sub capital {
  my ($self,$capital) = @_;
  $self->{capital} = $capital if @_ > 1;
  return $self->{capital};
}

sub population {
  my ($self,$population) = @_;
  $self->{population} = $population if @_ > 1;
  return $self->{population};
}
1;
