function list = dhRxnsForSetup(substrate,aerobicString)
error('not using')

    list = {};
    switch substrate
      case 'EX_glc(e)'
        switch aerobicString
          case 'aerobic'
            list= {'NADH16pp';
                   'GAPD';
                   'GLUDy';
                   'G6PDH2r';
                   'GND';
                   'PDH';
                   'FADRx';
                   'PGCD';
                   'ICDHyr';
                   'ASAD';
                   'MDH';
                   'MTHFD';
                   'KARA1';
                   'HSDy';
                   'IPMD';
                   'SHK3Dr';
                   'DHDPRy';
                   'HACD5';
                   'HACD2';
                   'HACD4';
                   'HACD1';
                   'HACD3';
                   'AGPR';
                   'KARA2';
                   'HACD7';
                   'HACD6';
                   'SULRi';
                   'ME1';
                   'LDH_D';};
          case 'anaerobic'
            list = {'GAPD';
                    'ACALD';
                    'ALCD2x';
                    'GLUDy';
                    'G6PDH2r';
                    'GND';
                    'FADRx';
                    'PGCD';
                    'ICDHyr';
                    'ASAD';
                    'MTHFD';
                    'KARA1';
                    'MDH';
                    'HSDy';
                    'IPMD';
                    'SHK3Dr';
                    'DHDPRy';
                    'HACD1';
                    'HACD2';
                    'HACD4';
                    'HACD5';
                    'HACD3';
                    'AGPR';
                    'KARA2';
                    'HACD6';
                    'HACD7';
                    'TRDR';
                    'ME1';
                    'LDH_D';};
        end
      case 'EX_xyl-D(e)'
        switch aerobicString
          case 'aerobic'
            list= {'NADH16pp';
                   'GAPD';
                   'PDH';
                   'GLUDy';
                   'G6PDH2r';
                   'GND';
                   'FADRx';
                   'PGCD';
                   'ICDHyr';
                   'ASAD';
                   'MDH';
                   'MTHFD';
                   'KARA1';
                   'HSDy';
                   'IPMD';
                   'SHK3Dr';
                   'DHDPRy';
                   'HACD1';
                   'HACD2';
                   'HACD4';
                   'HACD5';
                   'HACD3';
                   'AGPR';
                   'KARA2';
                   'HACD7';
                   'HACD6';
                   'TRDR';
                   'ME1';
                   'LDH_D';};
          case 'anaerobic'
            list = {'GAPD';
                    'ALCD2x';
                    'ACALD';
                    'GLUDy';
                    'G6PDH2r';
                    'GND';
                    'FADRx';
                    'PGCD';
                    'ICDHyr';
                    'ASAD';
                    'MTHFD';
                    'KARA1';
                    'MDH';
                    'HSDy';
                    'IPMD';
                    'SHK3Dr';
                    'DHDPRy';
                    'HACD1';
                    'HACD2';
                    'HACD4';
                    'HACD5';
                    'HACD3';
                    'AGPR';
                    'KARA2';
                    'HACD7';
                    'HACD6';
                    'TRDR';
                    'ME1';
                    'LDH_D';};
        end
    end

    if isempty(list)
        error('bad setup')
    end

end