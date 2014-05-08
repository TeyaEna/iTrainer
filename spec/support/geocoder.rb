Geocoder.configure(:lookup => :test)

Geocoder::Lookup::Test.add_stub(
  "New York, NY", [
    {
      'latitude'     => 40.7143528,
      'longitude'    => -74.0059731,
      'address'      => 'New York, NY, USA',
      'state'        => 'New York',
      'state_code'   => 'NY',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  "N17 7NP", [
    {
       'latitude'     => 51.6082388,
       'longitude'   => -0.0941598,
       'address'     => 'London N17 7NP, UK',
       'city'        => 'London',
       'state'       => '',
       'state_code'  => 'N17 7NP', 
       'country'     => 'UK'
    }
  ]
)

Geocoder::Lookup::Test.add_stub(
  "N16", [
   { 'latitude'  => 51.5623078,
     'longitude' => -0.0764353,
      'address'  => 'London N16, UK',
      'city'     => 'London',
      'state'    => '',
      'state_code' => 'N16',
      'country' => 'UK'
    }
  ]
)