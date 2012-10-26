function list = dhRxnList(count)

    if count==31
        list = {'3OAR100';
                '3OAR40';
                '3OAR60';
                '3OAR80';
                'AGPR';
                'AKGDH';
                'ASAD';
                'DHDPRy';
                'EAR40x';
                'EAR60x';
                'EAR80x';
                'G6PDH2r';
                'GAPD';
                'GLUDy';
                'GND';
                'HPYRRx';
                'HSDy';
                'ICDHyr';
                'IPMD';
                'KARA1';
                'KARA2';
                'MDH';
                'MTHFD';
                'NADH16pp';
                'PDH';
                'PGCD';
                'SHK3Dr';
                'TRSARr';
                'ME1';
                'LDH_D';
                'LCARR';};
    elseif strcmp(count,'manual')
               list = {'3OAR100';
                '3OAR40';
                '3OAR60';
                '3OAR80';
                'AGPR';
                'AKGDH';
                'ASAD';
                'DHDPRy';
                'EAR40x';
                'EAR60x';
                'EAR80x';
                'G6PDH2r';
                'GAPD';
                'GLUDy';
                'GND';
                'HPYRRx';
                'HSDy';
                'ICDHyr';
                'IPMD';
                'KARA1';
                'KARA2';
                'MDH';
                'MTHFD';
                'NADH16pp';
                'PDH';
                'PGCD';
                'SHK3Dr';
                % 'TRSARr'; removed because of loop result
                'ME1';
                'LDH_D';
                'LCARR';};
    else
        error('bad count')
    end

end