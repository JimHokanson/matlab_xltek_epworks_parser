classdef freerun_waveform < epworks.objects.result_object
    %
    %   Class:
    %   epworks.objects.freerun_waveform
    %
    %   See Also
    %   --------
    %   epworks.main
    %   epworks.objects.trace

    properties (Hidden)
        id_props = {'parent','trace'}
    end

    properties
        name
        lff_cutoff
        hff_cutoff
        notch_cutoff
        color
        parent
        trace
        data
    end

    methods
        function obj = freerun_waveform(p_main,p,logger)
            obj = obj@epworks.objects.result_object(p,logger);
            obj.name = p.data.trace_obj.name;
            obj.lff_cutoff = p.data.lff_cutoff;
            obj.hff_cutoff = p.data.hff_cutoff;
            obj.notch_cutoff = p.data.notch_cutoff;
            obj.color = p.data.color;

            obj.parent = p.parent.id;
            obj.trace = p.data.trace_obj.id;
        end
    end
end