;; kitty.in.th-lomo.scm
;; v. 0.04
;; Author Kitt Tientanopajai <kitty@kitty.in.th>
;; Copyright (C) 2005-2008 Kitt Tientanopajai"
;;
;; This is a free software and can be redistributed under GNU GPL version 2.
;; 
;; Lomography effect
;;
;; ChangeLogs
;; v0.04 - Mon, 15 Dec 2008 22:40:12 +0700
;; - Move to Filters menu

(define (kitty.in.th-lomo image drawable contrast saturation)
	(gimp-image-undo-group-start image)
	(let* (
		(image-width (car (gimp-image-width image)))
		(image-height (car (gimp-image-height image)))
		(image-layer (car (gimp-layer-new-from-drawable drawable image)))
		(feather-layer (car (gimp-layer-new image image-width image-height RGBA-IMAGE "kitty.in.th - feather" 80 OVERLAY-MODE)))
		(gradient-layer (car (gimp-layer-new image image-width image-height RGBA-IMAGE "kitty.in.th - gradient" 100 OVERLAY-MODE)))
		(fg (car (gimp-context-get-foreground)))
		(bg (car (gimp-context-get-background)))
		(feather 0))

		
		(gimp-layer-copy image-layer 1)
		(gimp-layer-set-name image-layer "kitty.in.th - color enhanced")
		(gimp-image-add-layer image image-layer -1)
		(gimp-brightness-contrast image-layer 0 contrast)
		(gimp-hue-saturation image-layer ALL-HUES 0 0 saturation)

		(if (> image-width image-height)
			(set! feather (/ image-width 10))
			(set! feather (/ image-height 10)))

		(gimp-image-add-layer image feather-layer -1)
		(gimp-image-set-active-layer image feather-layer)
		(gimp-selection-none image)
		(gimp-rect-select image feather feather (- image-width (* feather 2)) (- image-height (* feather 2)) CHANNEL-OP-ADD 1 (* feather 2))
		(gimp-selection-invert image)
		(gimp-context-set-foreground '(0 0 0))
		(gimp-edit-fill feather-layer FOREGROUND-FILL)
		(gimp-selection-none image)
		
		(gimp-context-set-foreground '(255 255 255))
		(gimp-context-set-background '(0 0 0))
		(gimp-image-add-layer image gradient-layer -1)
		
		(if (> image-width image-height)
			(gimp-edit-blend gradient-layer FG-BG-RGB-MODE NORMAL-MODE GRADIENT-RADIAL 100 0 REPEAT-NONE FALSE FALSE 0 0 TRUE (/ image-width 2) (/ image-height 2) image-width (/ image-height 2))
			(gimp-edit-blend gradient-layer FG-BG-RGB-MODE NORMAL-MODE GRADIENT-RADIAL 100 0 REPEAT-NONE FALSE FALSE 0 0 TRUE (/ image-width 2) (/ image-height 2) (/ image-width 2) image-height))
		
		(gimp-context-set-foreground fg)
		(gimp-context-set-background bg))

	(gimp-image-undo-group-end image)
	(gimp-displays-flush))

(script-fu-register
	"kitty.in.th-lomo"
	"<Image>/Filters/kitty.in.th/Lomo..."
	"kitty.in.th Lomography Effect v.0.04"
	"Kitt Tientanopajai"
	"Copyright (C) 2005-2008 Kitt Tientanopajai"
	"December 15, 2008"
	"RGB RGBA GRAY GRAYA"
	SF-IMAGE "Image" 0
	SF-DRAWABLE "Drawable" 0
	SF-ADJUSTMENT "Contrast" '(24 -127 127 1 10 0 0)
	SF-ADJUSTMENT "Saturation" '(20 -100 100 1 10 0 0))
