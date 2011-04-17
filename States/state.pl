#!/usr/bin/perl
print "Content-type: text/html\n\n";

use strict;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use Template;
use State;

my %state_list = (
    Alabama        => {capital    => "Montgomery",
                       population => 100000,
                      },
    Arizona        => {capital    => "Phoenix",
                       population => 200000,
                      },
    California     => {capital    => "Sacramento",
                       population => 300000,
                      },
    Colorado       => {capital    => "Denver",
                       population => 400000,
                      },
    Florida        => {capital    => "Tallahassee",
                       population => 500000,
                      },
    Hawaii         => {capital    => "Honolulu",
                       population => 600000,
                      },
    Michigan       => {capital    => "Lansing",
                       population => 700000,
                      },
    Pennsylvania   => {capital    => "Harrisburg",
                       population => 800000,
                      },
);

my %PARAMS = map{ $_, (param($_) ? param($_) : '')} param();

# define configs for template toolkit
my $config = {
        FILENAME     => 'state.tpl',
        INTERPOLATE  => 1,               # expand "$var" in plain text
        POST_CHOMP   => 1,               # cleanup whitespace 
        EVAL_PERL    => 1,               # evaluate Perl code blocks

};

# create template object
my $template = Template->new($config);

my %template_vals = (
                      ACTION => "state.pl",
                    );

# Call appropriate function to submit request
if ($PARAMS{EVENT}) {
  submitData();
}
else {
  showStart();
}

$template->process('state.tpl', \%template_vals) || die $template->error(), "\n";


sub showStart {
  my $state_obj = State->new( capital    => $state_list{'Michigan'}{capital},
                              population => $state_list{'Michigan'}{population},
  );

  setTemplateVals($state_obj);
}

sub submitData {
  my $new_capital  = $PARAMS{STATES}; 
  my ($new_population) = map{ $state_list{$_}{population} } grep{ $state_list{$_}{capital} eq $new_capital } keys %state_list;
  my $state_obj = State->new( capital    => $new_capital, 
                              population => $new_population,
  );
  setTemplateVals($state_obj);
}

sub setTemplateVals {
  my ($state_obj) = @_;
  $template_vals{STATES_DROPDOWN} = buildStates($state_obj->capital());
  $template_vals{CAPITAL}         = $state_obj->capital();
  $template_vals{POPULATION}      = $state_obj->population();
}

sub buildStates {
  my ($selected_capital) = @_;

  my @state_arr = map{"<option value=\"$state_list{$_}{capital}\"".($state_list{$_}{capital} eq $selected_capital ? 'selected' : '').">$_</option>"}keys %state_list;

  return join('',@state_arr);
}

__END__

=pod

=head1 NAME

state.pl

==head1 DESCRIPTION

This program is written to demonstrate basic understanding of Perl language and my coding style. 
It  magically displays state capital and imaginary population for the selected US state. 
It has a touch of OO Perl.

This program can be easily run under apache web server.

Copy state.pl, state.tpl and State.pm all under cgi-bin direcotry on apache web server.

Run it as http://<your host>/cgi-bin/state.pl

=head1 TODO

It creates only one state object and is too simple to cover inheritance or popymorphism. 

One thing I would like to update is to cache the state object in submitData()
and reuse it instead of creating a new object with every request.  

=head1 SEE ALSO

State.pm
state.tpl

==head1 DEPENDENCIES

CGI qw(:standard);
CGI::Carp qw(fatalsToBrowser);
Template;

=head1 COPYRIGHT AND DISCLAIMER

This code is open to copy, change, reuse or do whatever you can think of doing with it.
It belongs to Zakia Ahed and any comments emailed at z_ahed@yahoo.com will be greatly appreciated.

=cut
